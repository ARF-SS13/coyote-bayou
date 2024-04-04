import {
  useBackend,
  useLocalState
} from '../backend';
import {
  AnimatedNumber,
  Box,
  Button,
  Tooltip,
  Section,
  LabeledList,
  Stack,
  Table,
  Tabs,
  Icon,
} from '../components';
import { toFixed } from 'common/math';
import {
  formatMoney,
  formatTime,
} from '../format';
import { Window } from '../layouts';

/*
  SO HERES HOWS THIS GONNA GO DOWN
  Two main tabs
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
    QuestObjectivesComplete
    QuestObjectivesTotal
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
  const{
    QuestCount,
    QuestMax,
  } = data;

  // Active Quests is 1, Available Quests is 2, readme is 3
  const [
    SelectedTab,
    setSelectedTab,
  ] = useLocalState(context, 'SelectedTab', 1);

  const ActiveQuestsTitle = `Active Quests (${QuestCount}/${QuestMax})`;


  return (
    <Window
      width={640}
      height={480}
      title="Adventurer's Guild Quest Console"
      theme="ntos"
      resizable>
      <Window.Content
        style={{
          "background-image": "url('../../assets/bg-hornysex.png')",
          "background-size": "fill",
        }}>
        <Stack fill vertical>
          <Stack.Item>
            <TopToolbar />
          </Stack.Item>
          <Stack.Item>
          <Tabs
        fluid>
        <Tabs.Tab
          selected={SelectedTab === 1}
          onClick={() => setSelectedTab(1)}>
            {ActiveQuestsTitle}
        </Tabs.Tab>
        <Tabs.Tab
          selected={SelectedTab === 2}
          onClick={() => setSelectedTab(2)}>
            Available Quests
        </Tabs.Tab>
        <Tabs.Tab
          selected={SelectedTab === 3}
          onClick={() => setSelectedTab(3)}>
            Finished Quests
        </Tabs.Tab>
        <Tabs.Tab
          textAlign="center"
          selected={SelectedTab === 4}
          onClick={() => setSelectedTab(4)}>
            <Icon
              name="question-circle"
              color="green"
              size={1.5} />
        </Tabs.Tab>
      </Tabs>
          </Stack.Item>
          <Stack.Item grow shrink>
            <Section fill scrollable>
              <MainWindow />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <BottomToolbar />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
}

/// Common top toolbar for both panels
const TopToolbar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserName,
    BankedPoints,
    GlobalHighestCompleted,
    GlobalHighestBanked,
    GlobalQuestsCompleted,
    QuestsCompleted,
    HighestBankedPoints,
    GlobalTotalEarned,
    CurrencyUnit,
    Toots,
  } = data; // needs more gravy

  const TopEarnerColor = HighestBankedPoints >= GlobalHighestBanked ? "gold" : "label";
  const TopQuesterColor = QuestsCompleted >= GlobalHighestCompleted ? "gold" : "label";

  const YourQuestsTooltip = Toots.TTyourquests;
  const TopQuestsTooltip = Toots.TTtopquests;
  const TotalQuestsTooltip = Toots.TTglobalquests;

  const YourCashTooltip = Toots.TTyourbanked;
  const TopCashTooltip = Toots.TTtopbanked;
  const TotalCashTooltip = Toots.TTglobalbanked;

  const LeaderboardLavelFontSize = "10px";
  const LeaderboardValueFontSize = "12px";

  return (
    <Section
      title={`Welcome, ${UserName}!`}
      buttons={
        <YourCash />
      }>
      {/* Leaderboard stuff */}
      <Stack fill>
        <Stack.Item basis="50%"> {/* Quest Completions */}
          <Stack fill vertical>
            <Stack.Item>
              <Tooltip tooltip={YourQuestsTooltip}>
                <Stack fill>
                  <Stack.Item grow={1}>
                    <Box
                      inline
                      fontSize={LeaderboardLavelFontSize}>
                      Completed Quests
                    </Box>
                  </Stack.Item>
                  <Stack.Item shrink={1}>
                    <Box
                      inline
                      fontSize={LeaderboardValueFontSize}
                      color={TopQuesterColor}
                      fontWeight="bold">
                      <AnimatedNumber
                        initial={0}
                        value={QuestsCompleted}
                        color={TopQuesterColor}
                      />
                    </Box>
                  </Stack.Item>
                </Stack>
              </Tooltip>
            </Stack.Item>
            <Stack.Item>
              <Tooltip tooltip={TopQuestsTooltip}>
                <Stack fill>
                  <Stack.Item grow={1}>
                    <Box
                      inline
                      fontSize={LeaderboardLavelFontSize}>
                      Top Quester
                    </Box>
                  </Stack.Item>
                  <Stack.Item shrink={1}>
                    <Box
                      inline
                      fontSize={LeaderboardValueFontSize}
                      color={TopQuesterColor}
                      fontWeight="bold">
                      <AnimatedNumber
                        initial={0}
                        value={GlobalHighestCompleted}
                        color={TopQuesterColor}
                      />
                    </Box>
                  </Stack.Item>
                </Stack>
              </Tooltip>
            </Stack.Item>
            <Stack.Item>
              <Tooltip tooltip={TotalQuestsTooltip}>
                <Stack fill>
                  <Stack.Item grow={1}>
                    <Box
                      inline
                      fontSize={LeaderboardLavelFontSize}>
                      Total Quested
                    </Box>
                  </Stack.Item>
                  <Stack.Item shrink={1}>
                    <Box
                      inline
                      fontSize={LeaderboardValueFontSize}
                      color="label"
                      fontWeight="bold">
                      <AnimatedNumber
                        initial={0}
                        value={GlobalQuestsCompleted}
                        color="label"
                      />
                    </Box>
                  </Stack.Item>
                </Stack>
              </Tooltip>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item basis="50%"> {/* Cash Earned */}
          <Stack fill vertical>
            <Stack.Item>
              <Tooltip tooltip={YourCashTooltip}>
                <Stack fill>
                  <Stack.Item grow={1}>
                    <Box
                      inline
                      fontSize={LeaderboardLavelFontSize}>
                      Cash Earned
                    </Box>
                  </Stack.Item>
                  <Stack.Item shrink={1}>
                    <Box
                      inline
                      fontSize={LeaderboardValueFontSize}
                      color={TopEarnerColor}
                      fontWeight="bold">
                      <AnimatedNumber
                        initial={0}
                        value={HighestBankedPoints / 10}
                        format={value => formatMoney(value) + "" + CurrencyUnit}
                        color={TopEarnerColor}
                      />
                    </Box>
                  </Stack.Item>
                </Stack>
              </Tooltip>
            </Stack.Item>
            <Stack.Item>
              <Tooltip tooltip={TopCashTooltip}>
                <Stack fill>
                  <Stack.Item grow={1}>
                    <Box
                      inline
                      fontSize={LeaderboardLavelFontSize}>
                      Top Earner
                    </Box>
                  </Stack.Item>
                  <Stack.Item shrink={1}>
                    <Box
                      inline
                      fontSize={LeaderboardValueFontSize}
                      color={TopEarnerColor}
                      fontWeight="bold">
                      <AnimatedNumber
                        initial={0}
                        value={GlobalHighestBanked / 10}
                        format={value => formatMoney(value) + "" + CurrencyUnit}
                        color={TopEarnerColor}
                      />
                    </Box>
                  </Stack.Item>
                </Stack>
              </Tooltip>
            </Stack.Item>
            <Stack.Item>
              <Tooltip tooltip={TotalCashTooltip}>
                <Stack fill>
                  <Stack.Item grow={1}>
                    <Box
                      inline
                      fontSize={LeaderboardLavelFontSize}>
                      Total Earned
                    </Box>
                  </Stack.Item>
                  <Stack.Item shrink={1}>
                    <Box
                      inline
                      fontSize={LeaderboardValueFontSize}
                      color="label"
                      fontWeight="bold">
                      <AnimatedNumber
                        initial={0}
                        value={GlobalHighestBanked / 10}
                        format={value => formatMoney(value) + "" + CurrencyUnit}
                        color="label"
                      />
                    </Box>
                  </Stack.Item>
                </Stack>
              </Tooltip>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
}

/// The main window! either your quests or the available quests
const MainWindow = (props, context) => { // main screen turn on
  const { act, data } = useBackend(context);
  // Active Quests is 1, Available Quests is 2, readme is 3
  const [
    SelectedTab,
    setSelectedTab,
  ] = useLocalState(context, 'SelectedTab', 1);


  return (
    <>
        {SelectedTab === 1 && (
          <QuestList WhichOne={1} />
        )}
        {SelectedTab === 2 && (
          <QuestList WhichOne={2} />
        )}
        {SelectedTab === 3 && (
          <QuestList WhichOne={3} />
        )}
        {SelectedTab === 4 && (
          <ReadMe />
        )}
    </>
  );
}

/// The bottom toolbar for the main window
const BottomToolbar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    TimeToNext,
    BeepOnUpdate,
  } = data;

  const BeepToggleIcon = BeepOnUpdate ? "volume-up" : "volume-mute";
  const BeepToggleColor = BeepOnUpdate ? "green" : "label";
  const BeepToggleTip = BeepOnUpdate
    ? "You will be alerted when the quest pool updates!"
    : "You will NOT be alerted when the quest pool updates!";

  const CoolNumber = (
    <AnimatedNumber
      initial={0}
      value={TimeToNext}
      format={value => formatTime(value)}
      fontSize="16px"
      color="label"
    />
  );

  return (
    <Section fill>
      <Stack fill>
        <Stack.Item basis="50%">
          <Stack fill>
            <Stack.Item shrink={1}>
              <Button
                icon={BeepToggleIcon}
                iconColor={BeepToggleColor}
                iconSize={2}
                tooltip={BeepToggleTip}
                onClick={() => act('ToggleBeep')} />
            </Stack.Item>
            <Stack.Item grow={1}>
              <Box
                inline
                fontSize="14px"
                textAlign="center">
                {"Refresh in: "}
                {CoolNumber}
              </Box>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item basis="50%">
          <ButtonThatGivesPlayerAScanner />
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
    MyFinished = [],
  } = data;

  const Quests =
    props.WhichOne === 1
      ? MyQuests
      : props.WhichOne === 2
        ? AllQuests
        : props.WhichOne === 3
          ? MyFinished
          : [];

  const IsEmpty = Quests.length === 0;
  const WhyItEmpty = props.Mine ? "You have no active quests!" : "There are no quests available!";

  return (
    <Section>
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
    </Section>
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
    QuestObjectivesComplete,
    QuestObjectivesTotal,
    QuestIsTemplarte,
    QuestUID,
    CurrencyUnit = "₡",
  } = props.Quest;

  // templarte is quest pool, not active quest
  const IsDisabled = QuestIsTemplarte && QuestTaken;
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
        : QuestDifficulty === 4
          ? "gold"
          : QuestDifficulty === 8
            ? "orange"
            : "orange";
  const DiffIcon =
    QuestDifficulty === 1
      ? "grin-wink"
      : QuestDifficulty === 2
        ? "frown-open"
        : QuestDifficulty === 4
          ? "flushed"
          : QuestDifficulty === 8
            ? "dizzy"
            : "dizzy";
  const DiffiTooltip =
    QuestDifficulty === 1
      ? "This is an Easy quest!"
      : QuestDifficulty === 2
        ? "This is a Medium quest!"
        : QuestDifficulty === 4
          ? "This is a Hard quest!"
          : QuestDifficulty === 8
            ? "This is a CBT quest!"
            : "This quest is too much for you!";

  const CuteDiffi = (
    <Button
      icon={DiffIcon}
      iconSize={1.5}
      iconColor={DiffiColor}
      tooltip={DiffiTooltip}
      color="transparent" />
  );

  const RewardDisplay = `${formatMoney(QuestReward / 10)}${CurrencyUnit}`;
  const CanTakeThisQuest = QuestAcceptible && !IsTaken && IsTemplarte;
  /// truncates the description to 100 characters
  /// but only if QuestDesc isnt null
  const ShorterDesc = QuestDesc && QuestDesc.length > 150
    ? QuestDesc.substring(0, 150) + "..."
    : QuestDesc;
  const TooTip = "" + ShorterDesc + " -- Click for more information!";

  const Pingus = IsTemplarte
    ? ""
    : `${QuestObjectivesComplete}/${QuestObjectivesTotal}`;

  /// Should all fit in a single line
  return (
    <Button
      width="100%"
      tooltip={TooTip}
      disabled={IsDisabled}
      color={CuteColor}
      p={0.5}
      onClick={() => act('OpenQuest', {
        BountyUID: QuestUID,
        QuestIsMine: IsTaken,
        })}>
      <Stack fill>
        <Stack.Item shrink={1}>
          {/* <Icon
            name={CuteIcon}
            size={1.5}
            color={CuteIconColor} /> */}
          {CuteDiffi}
        </Stack.Item>
        <Stack.Item grow={1}>
          <Box
            inline
            fontSize="14px">
            {QuestName}
          </Box>
        </Stack.Item>
        <Stack.Item shrink={1}>
          <Box
            inline
            textAlign="right"
            fontSize="14px"
            textColor="green">
            {RewardDisplay}
          </Box>
        </Stack.Item>
        <Stack.Item basis="10%">
          <Box
            inline
            fontSize="14px"
            color={CuteColor}>
            {Pingus}
          </Box>
        </Stack.Item>
      </Stack>
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
  const TotalTip = "" + HighestTip + OverallTip + " Click to cash out!";

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
        format={value => formatMoney(value) + "" + CurrencyUnit}
        fontSize="16px"
        fontWeight="bold"
        color={IsGlobalHighest ? "gold" : "green"}
      />
    </Button>
  );
}

const ReadMe = (props, context) => {
  return (
    <Section>
      <Box>
        COMING SOON: how to use this darn thing =3
      </Box>
    </Section>
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
      fluid
      fitted
      iconColor="label"
      color="green"
      tooltip="Get you a turnin scanner!"
      onClick={() => act('GetScanner')}>
      Turn Stuff In!
    </Button>
  );
}



