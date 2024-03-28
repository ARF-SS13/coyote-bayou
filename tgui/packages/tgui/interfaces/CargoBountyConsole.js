import { useBackend, useLocalState } from '../backend';
import { toFixed } from 'common/math';
import { multiline } from 'common/string';
import { AnimatedNumber, Box, Button, Tooltip, Section, LabeledList, Stack } from '../components';
import { formatMoney } from '../format';
import { Window } from '../layouts';

/*
  SO HERES HOWS THIS GONNA GO DOWN
  Two main panels, one on top, one on the bottom, splut by a horizontal line
  Top panel has the list of your taken quests
    Top Panel Toolbar!
      Left side has your name and total active quests
        the total quests has a tooltip for how many youve done this round
      Right side has your ca$h and a Turnin Scanner button
        the ca$h has a tooltip for how much youve earned this round
  Bottom panel has the list of available quests
    Bottom Panel Toolbar!
      Left side has the time to next quest refresh and a BeepOnUpdate toggle
      Right side has the leaderboard
        Has Top Earner, Top Quester, Total Earned, and Total Quests Completed

  The panels will be scrollable. SCROLLABLE!
  Each panel will be populated by a list of cool fancy quest cards
  Each card will have a title, a description, a value, and a button to claim
  As well as a button to open the card into anothre window for more details
  */

/*
  VARS IN USE:
  All of em
    CurrencyUnit
  QuestLog Related:
    UserName
    AllQuests
    MyQuests
    TimeToNext
    BeepOnUpdate
    QuestCount
    QuestMax
    QuestsCompleted
    BankedPoints
    HighestBankedPoints
    GlobalQuestsCompleted
    GlobalHighestCompleted
    GlobalHighestBanked
  Quest Related:
    QuestName
    QuestDesc
    QuestDifficulty
    QuestInfo
    QuestReward
    QuestTaken
    QuestAcceptible
    QuestComplete
    QuestIsTemplarte
    QuestUID
  QuestQuota related
    QuotaName
    QuotaInfo
    QuotaNeeded
    QuotaGotten
    QuotaComplete
    QuotaMobsMustBeDead
    QuotaDeleteThing
*/


/// it also turns into a readme file!
export const CargoBountyConsole = (props, context) => {
  const { act, data } = useBackend(context);

  const [
    ReadmeMode,
    setReadmeMode,
  ] = useLocalState(context, 'ReadmeMode', false);

  return (
    <Window
      width={600}
      height={700}
      title="Adventurer's Guild Quest Console"
      theme="ntos"
      resizable>
      <Window.Content fitted>
        {ReadmeMode ? (
          <ReadmePanel />
        ) : (
          <Stack fill vertical>
            <Stack.Item shrink={1} basis="50%">
              <PersonalPanel /> {/* The QuestPool stuff */}
            </Stack.Item>
            <Stack.Item grow={1} basis="50%">
              <PoolPanel /> {/* The YourQuests stuff */}
            </Stack.Item>
          </Stack>
        )}
      </Window.Content>
    </Window>
  );
}

const PersonalPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserName,
  } = data;

  return (
    <Section height="100%">
      <Stack fill vertical>
        <Stack.Item>
          <Section
            title={"Welcome, " + UserName + "!"}
            fill
            fitted
            buttons={
              <Box
                inline>
                <YourCash />
                <ReadMeButton />
              </Box>
            }>
            <Stack fill>
              <Stack.Item grow={1}>
                <QuestCounter />
              </Stack.Item>
              <Stack.Item shrink={1}>
                <ButtonThatGivesPlayerAScanner />
              </Stack.Item>
            </Stack>
          </Section>
        </Stack.Item> {/* End of Top Panel Toolbar */}
        {/* needs to fill the rest of the space, no matter how little stuff is there */}
        <Stack.Item grow={1}>
          <QuestList Mine={true} />
        </Stack.Item>
      </Stack>
    </Section>
  );
}

const PoolPanel = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Section height="100%">
      <Stack fill vertical>
        <Stack.Item shrink={1}>
          <Stack fill>
            <Stack.Item grow={1}>
              <Section>
                <Box inline>
                  <BeepOnUpdateButton />
                  <TimeToNextQuest />
                  bingus
                </Box>
              </Section>
            </Stack.Item>
            <Stack.Item shrink={1}>
              <LeaderBoard />
            </Stack.Item>
          </Stack>
        </Stack.Item> {/* End of Top Panel Toolbar */}
        <Stack.Item shrink={1}>
          <Section height="100%" overflowY="hidden">
            <QuestList Mine={false} />
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
}


/// This is a big cute list of quest cards
/// can be either your quests or the available quests
const QuestList = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AllQuests = [],
    MyQuests = [],
  } = data;

  const Quests = props.Mine ? MyQuests : AllQuests;
  const IsEmpty = Quests.length === 0;
  const WhyItEmpty = props.Mine ? "You have no active quests!" : "There are no quests available!";

  return (
    <>
    {IsEmpty ? (
      <Box>
        {WhyItEmpty}
      </Box>
    ) : (
      <Box> {/* Quest */}
        {Quests.map(QuestEntry => (
            <QuestCard
              key={QuestEntry.QuestUID}
              Quest={QuestEntry}/>
        ))}
      </Box>
    )}
    </>
  );
}

/// A quest card! holds all the need-knows of the quest
/// is a big fancy button that opens the quest in a new window
/// contains:
///   Quest Name
///   Quest Description
///   Quest Reward
///   Quest Difficulty
const QuestCard = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    QuestName = "Untitled Quest",
    QuestDesc = "Top Secret!",
    QuestReward = 0,
    QuestDifficulty = 1,
    QuestTaken,
    QuestAcceptible,
    QuestComplete,
    QuestIsTemplarte,
    QuestUID,
    CurrencyUnit = "₡",
  } = props.Quest;

  // templarte is quest pool, not active quest
  const IsComplete = QuestComplete;
  const IsTaken = QuestTaken;
  const IsTemplarte = QuestIsTemplarte;

  const CuteIcon = IsTemplarte
    ? IsTaken
      ? "check-circle"
      : "circle"
    : IsComplete
      ? "check-circle"
      : "circle";
  const CuteIconColor = IsTemplarte
    ? IsTaken
      ? "green"
      : "label"
    : IsComplete
      ? "white"
      : "label";
  const CuteIconPosition = "left";
  const CuteColor = IsTemplarte
    ? IsTaken
      ? "label"
      : "blue"
    : IsComplete
      ? "green"
      : "blue";

  //#define QUEST_DIFFICULTY_EASY 1
  //#define QUEST_DIFFICULTY_MED 2
  //#define QUEST_DIFFICULTY_HARD 3
  //#define QUEST_DIFFICULTY_CBT 4
  const DiffiColor =
    QuestDifficulty === 1
      ? "green"
      : QuestDifficulty === 2
        ? "blue"
        : QuestDifficulty === 3
          ? "red"
          : "gold";
  const DiffIcon =
    QuestDifficulty === 1
      ? "fas fa-face-grin-wink"
      : QuestDifficulty === 2
        ? "fas fa-face-frown-open"
        : QuestDifficulty === 3
          ? "fas fa-face-flushed"
          : "fas fa-face-dizzy";
  const DiffiTooltip =
    QuestDifficulty === 1
      ? "This is an Easy quest!"
      : QuestDifficulty === 2
        ? "This is a Medium quest!"
        : QuestDifficulty === 3
          ? "This is a Hard quest!"
          : "This is a CBT quest!";

  const CuteDiffi = (
    <Button
      icon={DiffIcon}
      iconColor={DiffiColor}
      tooltip={DiffiTooltip}
      color="transparent" />
  );

  const RewardDisplay = `${formatMoney(QuestReward / 10)} ${CurrencyUnit}`;
  const CanTakeThisQuest = QuestAcceptible && !IsTaken && !IsTemplarte;
  const TooTip = "Click for more information!";
  /// truncates the description to 100 characters
  /// but only if QuestDesc isnt null
  const ShorterDesc = QuestDesc && QuestDesc.length > 150
    ? QuestDesc.substring(0, 150) + "..."
    : QuestDesc;

  return (
    <Button
      width="100%"
      tooltip={TooTip}
      color={CuteColor}
      icon={CuteIcon}
      iconColor={CuteIconColor}
      iconPosition={CuteIconPosition}
      onClick={() => act('OpenQuest', {
        BountyUID: QuestUID,
        QuestIsMine: IsTaken,
        })}>
      <Section
        title={QuestName}
        width="100%"
        buttons={
        <Stack fill>
          <Stack.Item grow={1}>
            <Box
              inline
              fontSize="16px"
              textColor={DiffiColor}
              fontWeight="bold"
              color="label">
              {RewardDisplay}
            </Box>
          </Stack.Item>
          <Stack.Item shrink={1}>
            {CuteDiffi}
          </Stack.Item>
        </Stack>
      }>
        <Box>
          {ShorterDesc}
        </Box>
      </Section>
    </Button>
  );
}

const YourCash = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    BankedPoints = 0,
    HighestBankedPoints = 0,
    GlobalHighestBanked = 0,
    CurrencyUnit = "₡",
  } = data;
  const ActualCash = toFixed(BankedPoints / 10, 0)
  const IsGlobalHighest = HighestBankedPoints >= GlobalHighestBanked;
  const OverallTip = "You have earned "
    + formatMoney(ActualCash)
    + CurrencyUnit
    + " this round!"
  const HighestTip = IsGlobalHighest ? "You are the highest earner this round!" : "";
  const TotalTip = `${HighestTip} ${OverallTip}`;

  return (
    <Button
      width="100px"
      tooltip={TotalTip}
      icon={IsGlobalHighest ? "star" : ""}
      iconColor="gold"
      iconPosition="right"
      onClick={() => act('CashOut')}>
      <AnimatedNumber
        initial={0}
        value={ActualCash} // we dont do cents here!
        format={value => formatMoney(value) + ` ${CurrencyUnit}`}
        fontSize="16px"
        fontWeight="bold"
        color={IsGlobalHighest ? "gold" : "green"}
      />
    </Button>
  );
}

const ReadMeButton = (props, context) => {
  const { act, data } = useBackend(context);
  const [
    ReadmeMode,
    setReadmeMode,
  ] = useLocalState(context, 'ReadmeMode', false);
  const ReadMeTip = ReadmeMode ? "Go back to questing" : "What the heck is all this?";
  return (
    <Button
      icon="info-circle"
      iconColor="Green"
      tooltip={ReadMeTip}
      onClick={() => setReadmeMode(!ReadmeMode)} />
  );
}

/// This is how many quests you currently have activee
const QuestCounter = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    QuestCount,
    QuestMax,
    QuestsCompleted,
    GlobalHighestCompleted,
  } = data;

  const IsTopQuester = QuestsCompleted >= GlobalHighestCompleted;
  const QuestTip = "You have completed " + QuestsCompleted + " quests this round!";
  const GlobalTip = IsTopQuester ? "You are the top quester this round!" : "";
  const TotalTip = `${GlobalTip} ${QuestTip}`

  return (
    <Button
      width="100%"
      tooltip={TotalTip}
      color="transparent"
      icon="check-circle"
      iconColor="Green"
      iconPosition="right">
      <AnimatedNumber
        initial={0}
        value={QuestCount}
        fontSize="16px"
        fontWeight="bold"
        color={QuestCount >= QuestMax ? "blue" : "green"}
      />
      <Box
        inline
        textColor="label"
        fontWeight="bold"
        fontSize="16px">
        {" / " + QuestMax}
      </Box>
    </Button>
  );
}

/// just a simple button that gives the player a scanner
/// the scanner is an item that you use to turn in things for quests
/// fancy!
const ButtonThatGivesPlayerAScanner = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Button
      icon="search"
      iconColor="label"
      color="green"
      tooltip="Get you a turnin scanner!"
      onClick={() => act('GetScanner')}>
      Scanner
    </Button>
  );
}

const TimeToNextQuest = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    TimeToNext,
  } = data;

  return (
    <Tooltip
      width="100px"
      tooltip="Time to next quest refresh!"
      color="transparent"
      icon="clock">
      {TimeToNext}
    </Tooltip>
  );
}

const BeepOnUpdateButton = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    BeepOnUpdate,
    CurrencyUnit,
  } = data;

  const BeepIcon = BeepOnUpdate ? "fas fa-volume-high" : "fas fa-volume-xmark";
  const BeepColor = BeepOnUpdate ? "green" : "label";
  const BeepTip = BeepOnUpdate
    ? "You'll be alerted when the quest pool updates!"
    : "You wont be alerted when the quest pool updates!";

  return (
    <Button
      icon={BeepIcon}
      iconColor={BeepColor}
      tooltip={BeepTip}
      onClick={() => act('ToggleBeep')} />
  );
}

const LeaderBoard = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserName,
    GlobalHighestCompleted,
    GlobalHighestBanked,
    GlobalQuestsCompleted,
    QuestsCompleted,
    HighestBankedPoints,
    CurrencyUnit,
  } = data;

  const TopEarnerColor = HighestBankedPoints >= GlobalHighestBanked ? "gold" : "label";
  const TopQuesterColor = QuestsCompleted >= GlobalHighestCompleted ? "gold" : "label";


  return (
    <Box
      inline
      fontSize="8px"
      fill
      fitted>
      <LabeledList>
        <LabeledList.Item
          label="Top Earner"
          buttons={
            <AnimatedNumber
              initial={0}
              value={toFixed(HighestBankedPoints / 10, 0)}
              format={value => formatMoney(value) + ` ${CurrencyUnit}`}
              color={TopEarnerColor}
            />
          }/>
        <LabeledList.Item
          label="Total Earned"
          buttons={
            <AnimatedNumber
              initial={0}
              value={GlobalHighestBanked / 10}
              format={value => formatMoney(value) + ` ${CurrencyUnit}`}
              color="label"
            />
          }/>
        <LabeledList.Item
          label="Top Quester"
          buttons={
            <AnimatedNumber
              initial={0}
              value={GlobalQuestsCompleted}
              color={TopQuesterColor}
            />
          }/>
        <LabeledList.Item
          label="Total Quests"
          buttons={
            <AnimatedNumber
              initial={0}
              value={GlobalHighestCompleted}
              color="label"
            />
          }/>
      </LabeledList>
    </Box>
  );
}



