import { useBackend, useLocalState } from '../backend';
import { toFixed } from 'common/math';
import { multiline } from 'common/string';
import { AnimatedNumber, Box, Button, Tooltip, Section, LabeledList, Fragment } from '../components';
import { formatMoney } from '../format';
import { Window } from '../layouts';

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
export const QuestWindow = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    CurrencyUnit,
    QuestName,
    QuestDesc,
    QuestDifficulty,
    QuestInfo,
    QuestReward,
    QuestTaken,
    QuestAcceptible,
    QuestComplete,
    QuestIsTemplarte,
    QuestUID,
  } = data;

  const [
    ReadmeMode,
    setReadmeMode,
  ] = useLocalState(context, 'ReadmeMode', false);

  const DifficultyText = {
    1: "Easy",
    2: "Medium",
    3: "Hard",
    4: "Nightmare",
  }[QuestDifficulty];

  let ShadeQuota = false;

  const IsTaken = QuestTaken && !QuestIsTemplarte;
  const CanTake = !IsTaken && QuestAcceptible;

  const AcceptOrCancel = () => {
    if (IsTaken) {
      return (
        <Button
          icon="times"
          color="bad"
          content="Cancel"
          onClick={() => act("CancelQuest", { BountyUID: QuestUID })} />
      );
    } else if (CanTake) {
      return (
        <Button
          icon="check"
          color="good"
          content="Accept"
          onClick={() => act("AcceptQuest", { BountyUID: QuestUID })} />
      );
    } else {
      return (
        <Button
          icon="times"
          content="Already Taken"
          disabled />
      );
    }
  }

  const ScanOrFinish = () => {
    if (!IsTaken) {
      return (
        <Button
          icon="times"
          content="Template"
          disabled />
      );
    } else if (QuestComplete) {
      return (
        <Button
          icon="check"
          color="good"
          content="Finish"
          onClick={() => act("FinishQuest", { BountyUID: QuestUID })} />
      );
    } else {
      return (
        <Button
          icon="search"
          content="Scan"
          onClick={() => act("GiveScanner", { BountyUID: QuestUID })} />
      );
    }
  }


  return (
    <Window
      width={600}
      height={900}
      title={`Quest! - ${DifficultyText}`}
      theme="ntos"
      resizable>
      <Window.Content
        style={{
          "background-image": "url('../../assets/bg-hornysex.png')",
          "background-size": "fill",
        }}>
        <Section fitted fill>
          <Stack fill vertical>
            {ReadmeMode ? (
              <ReadMeFile />
            ) : (
              <>
                <Stack.Item shrink={1}>
                  <Section
                    title={QuestName}
                    buttons={
                      <AnimatedNumber
                        initial={0}
                        value={QuestReward / 10}
                        format={value => formatMoney(value) + ` ${CurrencyUnit}`} />
                    }>
                    {QuestDesc}
                  </Section>
                </Stack.Item>
                <Stack.Item grow={1} shrink={1}>
                  <Section
                    fitted
                    fill
                    title={`Objectives: ${QuestObjectivesComplete}/${QuestObjectivesTotal}`}
                    buttons={
                    <ScanOrFinish />
                    }>
                    <Box
                      overflowY="auto"
                      fill
                      fluid
                      height="100%">
                      <Stack fill vertical>
                        {QuestInfo.map(Q => (
                          <Stack.Item key={Q.QuotaName}>
                            {ShadeQuota = !ShadeQuota}
                            <QuestQuota QUO={Q} Shade={ShadeQuota} />
                          </Stack.Item>
                        ))}
                      </Stack>
                    </Box>
                  </Section>
                </Stack.Item>
              </>
            )}
            <Stack.Item shrink={1}>
              <Stack fill>
                <Stack.Item shrink={1}>
                  <Button
                    icon="book"
                    content="Readme"
                    onClick={() => setReadmeMode(!ReadmeMode)} />
                </Stack.Item>
                <Stack.Item shrink={1}>
                  <Button
                    icon="fas fa-print"
                    content="Print"
                    onClick={() => act("PrintQuest", { BountyUID: QuestUID })} />
                </Stack.Item>
                <Stack.Item grow={1} /> {/* spacer */}
                <Stack.Item shrink={1}>
                  <AcceptOrCancel />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

const QuestQuota = (props, context) => {
  const { QUO } = props;
  const {
    QuotaName = "Bad StrRef",
    QuotaInfo = "Bad StrRef",
    QuotaNeeded = "Bad StrRef",
    QuotaGotten = "Bad StrRef",
    QuotaComplete = "Bad StrRef",
    QuotaMobsMustBeDead = "Bad StrRef",
    QuotaDeleteThing = "Bad StrRef",
  } = QUO;
  const {
    Shade = false,
  } = props;

  const QuotaAmountColor = QuotaComplete ? "good" : "label";
  const QuotaAmount = `${QuotaGotten}/${QuotaNeeded}`;
  const QuotaIcon = () => {
    if (QuotaComplete) {
      return "fas fa-circle-check"
    } else if (QuotaGotten < QuotaNeeded) {
      return "fas fa-circle-half-stroke"
    } else {
      return "fas fa-circle"
    }
  }
  const QuotaIconColor = QuotaComplete ? "good" : "label";
  const QuotaIconTooltip = QuotaComplete ? "Complete" : "Incomplete";

  const BGcolor = Shade ? "rgba(0,0,0,0.1)" : "rgba(0,0,0,0.0)";

  return (
    <Box
      p={1}
      mb={1}
      style={{
        "background-color": BGcolor,
      }}>
      <Stack fill>
        <Stack.Item>
          <Stack fill>
            <Stack.Item>
              <Tooltip
                content={QuotaIconTooltip}>
                <Icon
                  name={QuotaIcon()}
                  color={QuotaIconColor} />
              </Tooltip>
            </Stack.Item>
            <Stack.Item grow={1}>
              <Tooltip
                content={QuotaInfo}>
                <b>{QuotaName}</b>
              </Tooltip>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item shrink={1}>
          <Box
            color={QuotaAmountColor}
            textAlign="center">
            {QuotaAmount}
          </Box>
        </Stack.Item>
      </Stack>
    </Box>
  );
}




