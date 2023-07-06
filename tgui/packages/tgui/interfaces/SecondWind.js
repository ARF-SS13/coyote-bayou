import { useBackend } from '../backend';
import { Button, Section, ProgressBar, Flex, Stack, Box } from '../components';
import { Window } from '../layouts';

export const SecondWind = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      title="Second Wind"
      width={640}
      height={480}
      resizable>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <SecondWindTopBar />
          </Stack.Item>
          <Stack.Item grow>
            <SecondWindBody />
          </Stack.Item>
          <Stack.Item>
            <SecondWindBottomBar />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const SecondWindTopBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    PBarColors,
    TimeText,
    Percentage,
    TargTime,
  } = data.TimeData;
  let LowCol = "good";
  let MedCol = "average";
  let HighCol = "bad";
  switch (PBarColors) {
    case "good":
      LowCol = "good";
      MedCol = "good";
      HighCol = "good";
      break;
    case "average":
      LowCol = "average";
      MedCol = "average";
      HighCol = "average";
      break;
    case "bad":
      LowCol = "bad";
      MedCol = "bad";
      HighCol = "bad";
      break;
  }
  return (
    <Box>
      <Flex>
        <Flex.Item grow>
          <ProgressBar
            value={Percentage}
            minValue={0}
            maxValue={100}
            ranges={{
              LowCol: [0, 35],
              MedCol: [35, 65],
              HighCol: [65, 100],
            }}
            color="bad">
              {TimeText} / {TargTime}
          </ProgressBar>
        </Flex.Item>
        <Flex.Item shrink>
          <InfoButton />
        </Flex.Item>
      </Flex>
    </Box>
  );
};

const SecondWindInfoButton = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
  } = data;
  let ActDo = 'GoReadme';
  let ButtonIcon = 'info';
  if (UIState == "SWReadMe") {
    ActDo = 'GoHome';
    ButtonIcon = 'times';
  }
  return (
    <Button
      icon={ButtonIcon}
      tooltip="Second Wind Info"
      onClick={() => act(ActDo)}>
    </Button>
  );
};

const SecondWindBody = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    BodyHead,
    BodyFill,
    BodyHeadColor,
    ShowButtons,
  } = data.BodyData;
  return (
    <Section
      fill
      scrollable
      title={BodyHead}
      titleColor={BodyHeadColor}>
      {BodyFill}
    </Section>
  );
};

const SecondWindBottomBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    ShowButtons,
  } = data.BodyData;
  switch (ShowButtons) {
    case "OnlyConfirm":
      return (
        <SecondWindRevive />
      );
      break;
    case "OnlyBack":
      return (
        <SecondWindBack />
      );
      break;
    default:
      return (
        <Section />
      );
      break;
  }
};

const SecondWindRevive = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
  } = data;
  let ButtonLabel = "Revive";
  let ButtonIcon = "heartbeat";
  if (UIState == "SWConfirm") {
    ButtonLabel = "Confirm";
    ButtonIcon = "check";
  }
  return (
    <Section>
      <Button
        color="good"
        content={ButtonLabel}
        icon={ButtonIcon}
        onClick={() => act('ClickedRevive')} />
    </Section>
  );
};

const SecondWindBack = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
  } = data;
  let ButtonLabel = "Back";
  let ButtonIcon = "times";
  if (UIState == "SWConfirm") {
    ButtonLabel = "Cancel";
    ButtonIcon = "times";
  }
  return (
    <Section>
      <Button
        color="bad"
        content={ButtonLabel}
        icon={ButtonIcon}
        onClick={() => act('GoHome')} />
    </Section>
  );
};
