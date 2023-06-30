import { useBackend } from '../backend';
import { Button, Section, ProgressBar, Flex, Table, Stack, Fragment, Box, Tooltip } from '../components';
import { Window } from '../layouts';

export const SecondWind = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      width={400}
      height={300}
      resizable>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <TopBar />
          </Stack.Item>
          <Stack.Item grow>
            <Body />
          </Stack.Item>
          <Stack.Item>
            <BottomBar />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const TopBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
    TimeLeft,
    PercentLeft,
  } = data;
  if (UIState == "SWThirdWinded") {
    return (
      <Box>
        <Flex>
          <Flex.Item grow>
          <ProgressBar
            value={100}
            minValue={0}
            maxValue={100}
            ranges={{
              bad: [0, 100],
            }}
            color="bad"
            tooltip="Third Winded">
              THIRD WINDED
          </ProgressBar>
          </Flex.Item>
          <Flex.Item>
            <InfoButton />
          </Flex.Item>
        </Flex>
      </Box>
    );
  } else {
    return (
      <Box>
        <Flex>
          <Flex.Item grow>
          <ProgressBar
            value={PercentLeft}
            minValue={0}
            maxValue={100}
            ranges={{
              good: [0, 100],
            }}>
              {TimeLeft}
          </ProgressBar>
          </Flex.Item>
          <Flex.Item>
            <InfoButton />
          </Flex.Item>
        </Flex>
      </Box>
    );
  }
};

const InfoButton = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
  } = data;
  let ActDo = 'HelpMe';
  let ButtonIcon = 'info';
  if (UIState == "SWReadMe") {
    ActDo = 'GoBack';
    ButtonIcon = 'times';
  }
  return (
    <Box
      width="30px"
      height="30px">
      <Button
        icon="info"
        tooltip="Second Wind Info"
        onClick={() => act(ActDo)}>
      </Button>
    </Box>
  );
};

const Body = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
    RezCode,
    ThirdWindWarning,
    ReviveConfirmMsg,
    ReadMe,
  } = data;
  const {
    CodeName,
    CodeDesc,
    CodeColor,
  } = RezCode;
  if (UIState == "SWReadMe") {
    return (
      <Section
        title="Second Wind Info">
          {ReadMe}
      </Section>
    );
  } else if (UIState == "SWThirdWindWarning")
    return (
      <Section
        title="WARNING!!!">
          {ThirdWindWarning}
      </Section>
    );
  else if (UIState == "SWReviveConfirm")
    return (
      <Section
        title="Revive Confirmation">
          {ReviveConfirmMsg}
      </Section>
    );
  else {
    return (
      <Section
        title={<Box
          inline
          color={CodeColor}>
            CodeName
          </Box>}>
          {CodeDesc}
      </Section>
    );
  }
};

const BottomBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
    ShowButtons,
  } = data;
  if (UIState == "SWReadMe" ) {
    return (
      <Section>
        <Stack fill>
          <Stack.Item>
            <Button
              color="good"
              content="Back"
              icon="times"
              onClick={() => act('GoBack')} />
          </Stack.Item>
        </Stack>
      </Section>
    );
  } else if (!!ShowButtons) {
    return (
      <Section/>
    );
  } else if (UIState == "SWThirdWindWarning") {
    return (
      <Section>
        <Stack fill>
          <Stack.Item>
            <Button.Confirm
              color="good"
              content="Third Wind"
              icon="heartbeat"
              onClick={() => act('ThirdWindMe')} />
          </Stack.Item>
          <Stack.Item>
            <Button
              color="bad"
              content="Nevermind!"
              icon="times"
              onClick={() => act('GoBack')} />
          </Stack.Item>
        </Stack>
      </Section>
    );
  } else {
    return (
      <Section>
        <Stack fill>
          <Stack.Item>
            <Button.Confirm
              color="good"
              content="Revive"
              icon="heartbeat"
              onClick={() => act('Revive')} />
          </Stack.Item>
          <Stack.Item>
            <Button
              color="bad"
              content="Nevermind!"
              icon="times"
              onClick={() => act('GoBack')} />
          </Stack.Item>
        </Stack>
      </Section>
    );
  }
};
