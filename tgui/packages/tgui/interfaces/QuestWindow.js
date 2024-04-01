import { useBackend, useLocalState } from '../backend';
import { toFixed } from 'common/math';
import { multiline } from 'common/string';
import {
  AnimatedNumber,
  Box,
  Button,
  Tooltip,
  Section,
  LabeledList,
  NoticeBox,
  Icon,
  Stack,
  Fragment,
  ToggleBox,
} from '../components';
import { formatMoney } from '../format';
import { Window } from '../layouts';
import { marked } from 'marked';
import { sanitizeText } from '../sanitize';

/*
  SO HERES HOWS THIS GONNA GO DOWN
  Two main panels, one on top, one on the bottom, splut by a horizontal line
  Top panel is the quest flavor, its name and the (often garbo) description
  Bottom panel is the quest info, the quotas and the reward
    Top Toolbar:
      Objective counter (X/Y)
        reward amount on the right
      a big button that will give you a scanner if it isnt complete
        and will Finish the quest if it is complete
      Body (scrollable):
        List of Quota Cards
    Bottom Toolbar:
      Accept/Cancel button
    Title is "Quest! - Difficulty"
  */

/*
  VARS IN USE:
  All of em
    CurrencyUnit
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
  QuestObjectiveEntry related
    QuotaName
    QuotaInfo
    QuotaNeeded
    QuotaGotten
    QuotaComplete
    QuotaMobsMustBeDead
    QuotaDeleteThing
*/


/// it also turns into a readme file!
export const QuestWindow = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    QuestDifficulty,
    QuestDesc,
    QuestObjectivesTotal,
    ItBroke,
  } = data;

  const DifficultyText = {
    1: "Easy",
    2: "Medium",
    3: "Firm",
    4: "Hard",
    5: "Tough",
    6: "Rough",
    7: "For The Pros",
    8: "Nightmare",
    9: "Nightmarer",
    10: "Nightmarest",
    11: "Nightmarester",
    12: "Nightmarestest",
    13: "Nightmare But For Real This Time",
    14: "Nightmare But For Real This Time 2",
    15: "Nightmare But Open A Bug Report",
  }[QuestDifficulty];

  const WindoHight =
    150 // TopText
    + (QuestDesc ? QuestDesc.length / 50 : 50) * 50 // 50px per 50 characters
    + (QuestObjectivesTotal * 50) // 50px per quota
    + 100; // BottomBar

  return (
    <Window
      width={400}
      height={WindoHight}
      title={`Quest! - ${DifficultyText}`}
      theme="ntos"
      resizable>
      <Window.Content
        style={{
          "background-image": "url('../../assets/bg-hornysex.png')",
          "background-size": "fill",
        }}>
        {ItBroke && (
          <NoticeBox>
            No selected quest!
          </NoticeBox> // this is a lie
        ) || (
        <Stack fill vertical>
          <Stack.Item shrink>
            <TopText />
          </Stack.Item>
          <Stack.Item grow shrink>
            <Section fill scrollable>
              <QuestObjectiveList />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <BottomBar />
          </Stack.Item>
        </Stack>
        )}
      </Window.Content>
    </Window>
  );
};

// Flavor, Description, and reward
const TopText = (props, context) => {
  const { data, act } = useBackend(context);
  const {
    QuestName,
    QuestDesc,
    QuestReward,
    CurrencyUnit,
  } = data;

  const [
    ReadmeMode,
    setReadmeMode,
  ] = useLocalState(context, 'ReadmeMode', false);

  return (
    <Section
      title={QuestName}
      buttons={(
        <Box
          fontSize="14px"
          fontWeight="bold">
          <Stack fill>
            <Stack.Item grow={1}>
              <AnimatedNumber
                value={QuestReward}
                initial={0}
                format={value => formatMoney(value / 10) + ` ${CurrencyUnit}`}
                color="good" />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="info"
                onClick={() => setReadmeMode(!ReadmeMode)} />
            </Stack.Item>
          </Stack>
        </Box>
      )}>
      {ReadmeMode ? (
        <HelpText />
      ) : (
        <Box
          dangerouslySetInnerHTML={{ __html: QuestDesc }} />
      )}
    </Section>
  );
};

// List of Quotas to fill
const QuestObjectiveList = (props, context) => {
  const { data, act } = useBackend(context);
  const {
    QuestName,
    QuestDesc,
    QuestDifficulty,
    QuestInfo,
    QuestReward,
    QuestTaken,
    QuestAcceptible,
    QuestComplete,
    QuestIsTemplarte,
    QuestObjectivesComplete,
    QuestObjectivesTotal,
    QuestUID,
  } = data;

  let ShadeQuota = false;

  const Quotas = QuestInfo.map((QUO, index) => {
    ShadeQuota = !ShadeQuota;
    return (
      <QuestObjectiveEntry
        key={index}
        QUO={QUO}
        Shade={ShadeQuota}
        UID={QuestUID} />
    );
  });

  const ObjCounter = `${QuestObjectivesComplete}/${QuestObjectivesTotal}${QuestComplete ? " (!COMPLETE!)" : ""}`;
  const ObjCounterColor = QuestComplete ? "gold" : "label";
  const ObjBold = QuestComplete ? "bold" : "normal";

  return (
    <Box p={1}>
      <Box fontSize="14px">
        <Stack fill>
          <Stack.Item grow={1}>
            <Box fontSize="14px">
              Objectives: <b style={{ "font-weight": ObjBold, "color": ObjCounterColor }}>{ObjCounter}</b>
            </Box>
          </Stack.Item>
          {QuestComplete && (
            <Stack.Item>
              <Button
                icon="check"
                style={{
                  "background-color": "green",
                  "border-color": "gold",
                  "border-width": "2px",
                }}
                fitted
                m={0}
                p={0}
                content="FINISH!"
                onClick={() => act("FinishQuest", { BountyUID: QuestUID })} />
            </Stack.Item>
          )}
        </Stack>
      </Box>
      {Quotas}
    </Box>
  );
};

/// A cool slug of a quest objective!
const QuestObjectiveEntry = (props, context) => {
  const { data, act } = useBackend(context);
  const { QUO } = props;
  const {
    QuotaName = "Bad StrRef",
    QuotaInfo = "Bad StrRef",
    QuotaNeeded = "Bad StrRef",
    QuotaGotten = "Bad StrRef",
    QuotaComplete = "Bad StrRef",
    QuotaMobsMustBeDead = "Bad StrRef",
    QuotaDeleteThing = "Bad StrRef",
    QuotaUID = "Bad StrRef",
    ImCoder = true,
  } = QUO;
  const {
    Shade = false,
    UID = "Bad StrRef",
  } = props;

  const QuotaAmountColor = QuotaComplete ? "good" : "label";
  const QuotaAmount = `${QuotaGotten}/${QuotaNeeded}`;
  const QuotaIcon = () =>{
    if (QuotaComplete) {
      return "circle-check"
    } else if (QuotaGotten < QuotaNeeded) {
      return "circle-half-stroke"
    } else {
      return "circle"
    }
  }
  const QuotaIconColor = QuotaComplete ? "good" : "label";
  const QuotaIconTooltip = QuotaComplete ? "Complete" : "Incomplete";

  // thow shade for me, shade for me, SHADE
  const BGcolor = Shade ? "rgba(0,0,0,0.1)" : "rgba(0,0,0,0.0)";
  const sanitizedText = sanitizeText(QuotaInfo);
  const formattedText = marked(sanitizedText, { smartypants: true, gfm: true, tables: true, sanitize: false, breaks: true, smartLists: true });

  const ClosedContent = (
    <Stack fill>
      <Stack.Item grow={1}>
        <Box fontSize="14px" fluid>
          <Icon
            name={QuotaIcon()}
            color={QuotaIconColor}
            tooltip={QuotaIconTooltip} />
          {QuotaName}
        </Box>
      </Stack.Item>
      <Stack.Item>
        <Box fontSize="14px" fluid>
          <b style={{ "color": QuotaAmountColor }}>{QuotaAmount}</b>
        </Box>
      </Stack.Item>
    </Stack>
  );
  const OpenContent = (
    <Stack fill vertical>
      <Stack.Item>
        {ClosedContent}
      </Stack.Item>
      <Stack.Item>
        <Box
          fontSize="14px"
          dangerouslySetInnerHTML={{ __html: formattedText }} />
      </Stack.Item>
    </Stack>
  );
  const DebugObjectiveButton = () => {
    if (ImCoder) {
      return (
        <Button
          icon="code"
          content="Debug +1"
          onClick={() => act("DebugGiveObjectivePoint", {
            QuotaUID: QuotaUID,
            BountyUID: UID,
          })} />
          );
    }
    return <Fragment />;
  }

  return (
    <>
      <ToggleBox
        fluid
        wra
        OpenStuff={OpenContent}
        ClosedStuff={ClosedContent} />
      <DebugObjectiveButton />
    </>
  );
};


// Bottom toolbar
// Has the Accept/GIMME SCANNER button
// has a cancel button (its a confirm button!!)
// Has the non-functional printer button
const BottomBar = (props, context) => {
  const { data, act } = useBackend(context);
  const {
    QuestName,
    QuestDesc,
    QuestDifficulty,
    QuestInfo,
    QuestReward,
    QuestTaken,
    QuestAcceptible,
    QuestComplete,
    QuestIsTemplarte,
    QuestObjectivesComplete,
    QuestObjectivesTotal,
    QuestUID,
  } = data;

  return (
    <Section>
      <Stack fill>
        <Stack.Item>
          <Stack fill>
            <Stack.Item grow={1}>
              <AcceptOrScan />
            </Stack.Item>
            <Stack.Item>
              <CancelMaybe />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Button
            icon="print"
            content="Print"
            onClick={() => act("PrintQuest", { BountyUID: QuestUID })} />
        </Stack.Item>
      </Stack>
    </Section>
  );
}

// Accept or Scan button
const AcceptOrScan = (props, context) => {
  const { data, act } = useBackend(context);
  const {
    QuestName,
    QuestDesc,
    QuestDifficulty,
    QuestInfo,
    QuestReward,
    QuestTaken,
    QuestAcceptible,
    QuestComplete,
    QuestIsTemplarte,
    QuestObjectivesComplete,
    QuestObjectivesTotal,
    QuestUID,
  } = data;
  const IsTaken = QuestTaken && !QuestIsTemplarte;
  const CanTake = !IsTaken && QuestAcceptible;

  if (IsTaken) {
    return (
      <Button
        icon="scanner"
        content="GIMME SCANNER"
        onClick={() => act("GiveScanner", { BountyUID: QuestUID })} />
    );
  } else if (CanTake) {
    return (
      <Button
        icon="hand-paper"
        content="Accept"
        onClick={() => act("AcceptQuest", { BountyUID: QuestUID })} />
    );
  }
  return <Fragment />;
}

// Cancel button
const CancelMaybe = (props, context) => {
  const { data, act } = useBackend(context);
  const {
    QuestName,
    QuestDesc,
    QuestDifficulty,
    QuestInfo,
    QuestReward,
    QuestTaken,
    QuestAcceptible,
    QuestComplete,
    QuestIsTemplarte,
    QuestObjectivesComplete,
    QuestObjectivesTotal,
    QuestUID,
  } = data;
  const IsTaken = QuestTaken && !QuestIsTemplarte;
  const CanTake = !IsTaken && QuestAcceptible;

  if (IsTaken) {
    return (
      <Button
        icon="times"
        content="Cancel"
        onClick={() => act("CancelQuest", { BountyUID: QuestUID })} />
    );
  }
  return <Fragment />;
}

// The readme file
const HelpText = (props, context) => {
  const { data, act } = useBackend(context);

  return (
    <Box>
      <NoticeBox>
        <Box>
          <b>Quest Readme</b>
        </Box>
        <Box>
          <b>Quests</b> are a way to earn money and experience by completing tasks.
        </Box>
        <Box>
          <b>Objectives</b> are the tasks you need to complete to finish a quest.
        </Box>
        <Box>
          <b>Quotas</b> are the individual parts of an objective.
        </Box>
        <Box>
          <b>Quota</b> is the name of the task.
        </Box>
        <Box>
          <b>Amount</b> is how many of the task you need to complete.
        </Box>
        <Box>
          <b>Info</b> is a description of the task.
        </Box>
        <Box>
          <b>Complete</b> is whether or not you have completed the task.
        </Box>
        <Box>
          <b>Quotas</b> are the individual parts of an objective.
        </Box>
        <Box>
          <b>Quotas</b> are the individual parts of an objective.
        </Box>
        <Box>
          <b>Quotas</b> are the individual parts of an objective.
        </Box>
        <Box>
          <b>Quotas</b> are the individual parts of an objective.
        </Box>
        <Box>
          <b>Quotas</b> are the individual parts of an objective.
        </Box>
        <Box>
          <b>Quotas</b> are the individual parts of an objective.
        </Box>
        <Box>
          <b>Quotas</b> are the individual parts of an objective.
        </Box>
      </NoticeBox>
    </Box>
  );
}





