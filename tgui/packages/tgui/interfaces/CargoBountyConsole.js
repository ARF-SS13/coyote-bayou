/* eslint-disable */
import {
  useBackend,
  useLocalState,
} from '../backend';
import {
  AnimatedNumber,
  Box,
  Button,
  Tooltip,
  Section,
  LabeledList,
  Stack,
  Flex,
  Table,
  Fragment,
  Tabs,
  Icon,
} from '../components';
import { toFixed } from 'common/math';
import {
  formatMoney,
  formatTime,
} from '../format';
import { Window } from '../layouts';
import { multiline } from '../../common/string';

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
    OverallBankedPoints
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


// / it also turns into a readme file!
export const CargoBountyConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
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
                onClick={() => {
                  setSelectedTab(1);
                  act('JustUpdate');
                }}>
                {ActiveQuestsTitle}
              </Tabs.Tab>
              <Tabs.Tab
                selected={SelectedTab === 2}
                onClick={() => {
                  setSelectedTab(2);
                  act('JustUpdate');
                }}>
                Available Quests
              </Tabs.Tab>
              <Tabs.Tab
                selected={SelectedTab === 3}
                onClick={() => {
                  setSelectedTab(3);
                  act('JustUpdate');
                }}>
                Finished Quests
              </Tabs.Tab>
              <Tabs.Tab
                textAlign="center"
                selected={SelectedTab === 4}
                onClick={() => {
                  setSelectedTab(4);
                  act('JustUpdate');
                }}>
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
};

// / a leaderboard entry!
// / has a name, a value, and a tooltip, and if the number should be gold
const LeaderTip = (props) => {
  const {
    TName,
    Tip,
    Gold,
    Value,
  } = props;

  return (
    <Button
      m={-1}
      p={-1}
      width="75%"
      color="#f0f8ff"
      tooltip={Tip}>
      <Stack fill>
        <Stack.Item grow={1}>
          <Box
            inline
            fontSize="10px">
            <Icon
              name="star"
              size={0.85}
              color={Gold ? "gold" : "label"} />
            {TName}
          </Box>
        </Stack.Item>
        <Stack.Item shrink={1}>
          <Box
            inline
            fontSize="12px"
            color={Gold ? "gold" : "label"}
            fontWeight="bold">
            {Value}
          </Box>
        </Stack.Item>
      </Stack>
    </Button>
  );
};

// / Common top toolbar for both panels
const TopToolbar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserName,
    CurrencyUnit,
    QuestsCompleted,
    QuestHistoryCount,
    GlobalHistoricalQuestsCompleted,
    GlobalQuestsCompleted,
    GlobalHighestCompleted,
    BankedPoints,
    HistoricalBankedPoints,
    GlobalHistoricalBanked,
    OverallBankedPoints,
    GlobalHighestBanked,
    GlobalTotalEarned,
    Toots,
  } = data; // needs more gravy

  /*
  Toots.AmTopQuester
  Toots.AmTopEarner
  Toots.AmTopQuesterHistorical
  Toots.AmTopEarnerHistorical
*/

  const YourQuestsTooltip = Toots.TTyourquests;
  const TopQuestsTooltip = Toots.TTtopquests;
  const YourHistoricalQuestsTooltip = Toots.TThistoricalquests;
  const TopHistoricalQuestsTooltip = Toots.TTtophistoricalquests;
  const GlobalQuestsTooltip = Toots.TTglobalquests;

  const YourBankedTooltip = Toots.TTyourbanked;
  const TopBankedTooltip = Toots.TTtopbanked;
  const YourHistoricalBankedTooltip = Toots.TThistoricalbanked;
  const TopHistoricalBankedTooltip = Toots.TTtophistoricalbanked;
  const GlobalBankedTooltip = Toots.TTglobalbanked;

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
              <LeaderTip
                TName="Completed Quests (Today)"
                Tip={YourQuestsTooltip}
                Gold={Toots.AmTopQuester}
                Value={QuestsCompleted} />
            </Stack.Item>
            <Stack.Item>
              <LeaderTip
                TName="Completed Quests (All Time)"
                Tip={YourHistoricalQuestsTooltip}
                Gold={false}
                Value={QuestHistoryCount} />
            </Stack.Item>
            <Stack.Item>
              <LeaderTip
                TName="Top Quester"
                Tip={TopQuestsTooltip}
                Gold={Toots.AmTopQuester}
                Value={GlobalHighestCompleted} />
            </Stack.Item>
            <Stack.Item>
              <LeaderTip
                TName="Global Completed Quests"
                Tip={GlobalQuestsTooltip}
                Gold={false}
                Value={GlobalQuestsCompleted} />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item basis="50%"> {/* Cash Earned */}
          <Stack fill vertical>
            <Stack.Item>
              <LeaderTip
                TName="Earnings (Recent)"
                Tip={YourBankedTooltip}
                Gold={Toots.AmTopEarner}
                Value={`${CurrencyUnit} ${formatMoney(OverallBankedPoints / 10)}`} />
            </Stack.Item>
            <Stack.Item>
              <LeaderTip
                TName="Earnings (All Time)"
                Tip={YourHistoricalBankedTooltip}
                Gold={false}
                Value={`${CurrencyUnit} ${formatMoney(HistoricalBankedPoints / 10)}`} />
            </Stack.Item>
            <Stack.Item>
              <LeaderTip
                TName="Top Earner"
                Tip={TopBankedTooltip}
                Gold={Toots.AmTopEarner}
                Value={`${CurrencyUnit} ${formatMoney(GlobalHighestBanked / 10)}`} />
            </Stack.Item>
            <Stack.Item>
              <LeaderTip
                TName="Global Earnings"
                Tip={GlobalBankedTooltip}
                Gold={false}
                Value={`${CurrencyUnit} ${formatMoney(GlobalTotalEarned / 10)}`} />
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// / The main window! either your quests or the available quests
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
};

// / The bottom toolbar for the main window
const BottomToolbar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    TimeToNext,
    BeepOnUpdate,
    scanning_mobs_makes_nests_dump_questable_mobs,
  } = data;

  const BeepToggleIcon = BeepOnUpdate ? "volume-up" : "volume-mute";
  const BeepToggleColor = BeepOnUpdate ? "green" : "label";
  const BeepToggleTip = BeepOnUpdate
    ? "You will be alerted when the quest pool updates!"
    : "You will NOT be alerted when the quest pool updates!";

  const CoolNumber = (
    <Box inline
      fontSize="16px"
      color="label" >
      {formatTime(TimeToNext)}
    </Box>
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
        <Stack.Item basis="10%">
          <Button
            icon={scanning_mobs_makes_nests_dump_questable_mobs ? "house-signal" : "rss"}
            iconColor={scanning_mobs_makes_nests_dump_questable_mobs ? "green" : "label"}
            iconSize={2}
            tooltip={scanning_mobs_makes_nests_dump_questable_mobs
              ? "Scanning a mob that had spawned from a nest will trigger the nest to dump out mobs relating to your quests! Click here to make it not do that."
              : "Scanning a mob that had spawned from a nest will NOT trigger the nest to dump out mobs relating to your quests! Click here to make it do that."}
            onClick={() => act('ToggleNestDump')} />
        </Stack.Item>
        <Stack.Item basis="40%">
          <Button
            icon="search"
            iconSize={2}
            fluid
            fitted
            iconColor="label"
            color="green"
            tooltip="Get you a turnin scanner!"
            onClick={() => act('GetScanner')}>
            Turn Stuff In!
          </Button>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// / This is a big cute list of quest cards
// / can be either your quests or the available quests
const QuestList = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AllQuests = [],
    MyQuests = [],
    MyFinished = [],
  } = data;

  const Quests
    = props.WhichOne === 1
      ? MyQuests
      : props.WhichOne === 2
        ? AllQuests
        : props.WhichOne === 3
          ? MyFinished
          : [];

  const IsEmpty = Quests.length === 0;
  const WhyItEmpty = props.WhichOne === 1
    ? "You have no active quests!"
    : props.WhichOne === 2
      ? "There are no quests available!"
      : props.WhichOne === 3
        ? "You have not completed any quests!"
        : "You have no quests!";

  return (
    <Section>
      {/* {WhyItEmpty} */}
      {/* Quest */}
      {Quests.map(QuestEntry => (
        <QuestCard
          key={QuestEntry.QuestUID}
          WhichOne={props.WhichOne}
          Quest={QuestEntry} />
      ))}
      <HistoryPanel />
    </Section>
  );
};

// / A quest card! holds all the need-knows of the quest
// / is a big fancy button that opens the quest in a new window
// / contains:
// /   Quest Name
// /   Quest Description
// /   Quest Reward
// /   Quest Difficulty
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
    WhichOne,
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

  // #define QUEST_DIFFICULTY_EASY 1
  // #define QUEST_DIFFICULTY_MED 2
  // #define QUEST_DIFFICULTY_HARD 3
  // #define QUEST_DIFFICULTY_CBT 4
  const DiffiColor
    = QuestDifficulty === 1
      ? "green"
      : QuestDifficulty === 2
        ? "blue"
        : QuestDifficulty === 4
          ? "gold"
          : QuestDifficulty === 8
            ? "orange"
            : "orange";
  const DiffIcon
    = QuestDifficulty === 1
      ? "grin-wink"
      : QuestDifficulty === 2
        ? "meh"
        : QuestDifficulty === 4
          ? "flushed"
          : QuestDifficulty === 8
            ? "tired"
            : "tired";
  const DiffiTooltip
    = QuestDifficulty === 1
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
      // tooltip={DiffiTooltip}
      color="transparent" />
  );

  const RewardDisplay = `${CurrencyUnit} ${formatMoney(QuestReward / 10)}`;
  const CanTakeThisQuest = QuestAcceptible && !IsTaken && IsTemplarte;
  // / truncates the description to 100 characters
  // / but only if QuestDesc isnt null
  const ShorterDesc = QuestDesc && QuestDesc.length > 150
    ? QuestDesc.substring(0, 150) + "..."
    : QuestDesc;
  const TooTip = "" + ShorterDesc + " -- Click for more information!";

  const Pingus = WhichOne === 1
    ? `${QuestObjectivesComplete}/${QuestObjectivesTotal}`
    : "";

  // / Should all fit in a single line
  return (
    <Button
      width="100%"
      // tooltip={TooTip}
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
};

const YourCash = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    BankedPoints = 0,
    OverallBankedPoints = 0,
    GlobalHighestBanked = 0,
    CurrencyUnit = "₡",
  } = data;
  const ActualCash = toFixed(BankedPoints / 10, 0);
  const IsGlobalHighest = OverallBankedPoints >= GlobalHighestBanked;
  const OverallTip = "You have earned "
    + CurrencyUnit
    + formatMoney(ActualCash)
    + " this round!";
  const HighestTip = IsGlobalHighest ? "You are the highest earner this round!" : "";
  const TotalTip = "" + HighestTip + OverallTip + " Click to cash out!";

  return (
    <Button
      width="100px"
      tooltip={TotalTip}
      icon={IsGlobalHighest ? "star" : ""}
      iconColor="gold"
      iconPosition="left"
      onClick={() => act('CashOut')}>
      {CurrencyUnit + " "}
      <AnimatedNumber
        initial={0}
        value={ActualCash} // we dont do cents here!
        format={value => `${formatMoney(value)}`}
        fontSize="16px"
        fontWeight="bold"
        color={IsGlobalHighest ? "gold" : "green"}
      />
    </Button>
  );
};

const ReadMe = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    ReadmeText = "bemis is a big ol' dummy!",
  } = data;
  return (
    <Section>
      <Box
        dangerouslySetInnerHTML={{ __html: ReadmeText }}
      />

    </Section>
  );
};

// / The quest history panel, for  quests finished in previous rounds
const HistoryPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const [
    SelectedTab,
    setSelectedTab,
  ] = useLocalState(context, 'SelectedTab', 1);

  if (SelectedTab !== 3) {
    return <Box />;
  }

  const {
    QuestHistory = [], // this has a different format to normal quests
  } = data;
  let Keykey = 0;

  const IsEmpty = QuestHistory.length === 0;
  const WhyItEmpty = "You haven't completed any quests... before today, that is!";
  return (
    <Section
      title="Quest History">
      {IsEmpty ? (
        <Box>
          {WhyItEmpty}
        </Box>
      ) : (
        <Flex wrap justify="space-around">
          {QuestHistory.map(QuestEntry => (
            <Flex.Item
              key={Keykey++}
              basis="40%">
              <HistoryCard
                key={Keykey}
                Quest={QuestEntry} />
            </Flex.Item>
          ))}
        </Flex>
      )}
    </Section>
  );
};

/*
  VARS FOR HISTORY CARD
    FinQuester
    FinQuestName
    FinQuestDescription
    FinQuestTime
    FinQuestRound
    FinQuestDifficulty
    FinQuestReward
    FinQuestObjectives
*/

// / A card for the quest history panel
// / Mush simpler, is not even a button!
const HistoryCard = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    FinQuester = "RELPH",
    FinQuestName = "Untitled Quest",
    FinQuestDescription = "Top Secret!",
    FinQuestTime = 0,
    FinQuestRound = 0,
    FinQuestDifficulty = 1,
    FinQuestReward = 0,
    FinQuestObjectives = [],
    CurrencyUnit = "₡",
  } = props.Quest;

  const RewardDisplay = `${CurrencyUnit}${formatMoney(FinQuestReward / 10)}`;
  const DiffiColor
    = FinQuestDifficulty === 1
      ? "green"
      : FinQuestDifficulty === 2
        ? "blue"
        : FinQuestDifficulty === 4
          ? "gold"
          : FinQuestDifficulty === 8
            ? "orange"
            : "orange";
  const DiffIcon
    = FinQuestDifficulty === 1
      ? "grin-wink"
      : FinQuestDifficulty === 2
        ? "meh"
        : FinQuestDifficulty === 4
          ? "flushed"
          : FinQuestDifficulty === 8
            ? "tired"
            : "tired";
  const DiffiTooltip
    = FinQuestDifficulty === 1
      ? "This was an Easy quest!"
      : FinQuestDifficulty === 2
        ? "This was a Medium quest!"
        : FinQuestDifficulty === 4
          ? "This was a Hard quest!"
          : FinQuestDifficulty === 8
            ? "This was a CBT quest!"
            : "This was a quest of all time!";

  const CuteDiffi = (
    <Icon
      name={DiffIcon}
      size={1.5}
      color={DiffiColor} />
  );
  const PaleBlue = "#f0f8ff";
  let Keytwo = 0;

  return (
    <Box
      style={{
        "border": "1px solid #000000",
        "border-radius": "20px",
        "background-color": "rgba(0, 0, 0, 0.5)",
      }}
      p={1.5}
      m={1}>
      <Stack fill vertical>
        <Stack.Item shrink={1}>
          <Stack fill>
            <Stack.Item grow={1}>
              <Box
                inline
                textAlign={"left"}
                fontSize="10px">
                {CuteDiffi}
              </Box>
            </Stack.Item>
            <Stack.Item grow={1}>
              <Box
                inline
                fontSize="10px">
                {FinQuestName}
              </Box>
            </Stack.Item>
            <Stack.Item shrink={1}>
              <Box
                inline
                textAlign="right"
                fontSize="10px"
                textColor="green">
                {RewardDisplay}
              </Box>
            </Stack.Item>
            <Stack.Item shrink={1}>
              <Box
                inline
                fontSize="10px"
                textColor="label">
                {`R: ${FinQuestRound}`}
              </Box>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        {FinQuestObjectives.map(Objective => (
            <Stack.Item>
              <ObjectiveCard
                key={Keytwo++}
                Objective={Objective}/>
            </Stack.Item>
          ))}
      </Stack>
    </Box>
  );
};

// / A card for the quest history panel
// / Mush simpler, is not even a button!
const ObjectiveCard = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    qfbq_name = "Untitled Objective",
    qfbq_gotten_amount = 0,
    qfbq_needed_amount = 1,
    qfbq_price_per_thing = 0,
    CurrencyUnit = "₡",
  } = props.Objective;

  const RewardDisplay = `${CurrencyUnit}${formatMoney(qfbq_price_per_thing / 10)}`;
  const NameDesplay = `${qfbq_name} - ${qfbq_gotten_amount}/${qfbq_needed_amount}`;
  const ObjectiveColor = "green"; // "label

  return (
    <Box p={0.3} color="#f0f8ff">
      {`${NameDesplay} - ${RewardDisplay} x ${qfbq_needed_amount}`}
    </Box>
  );
};


