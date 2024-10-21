import { useBackend } from '../backend';
import { Button, Section, ProgressBar, Flex, Stack, Box, Icon } from '../components';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';
import { marked } from 'marked';

export const SecondWind = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
    AmInTown,
  } = data;
  const {
    BodyHead,
    BodyFill,
    BodyHeadIconColor,
    BodyHeadIconImg,
    ShowButtons,
  } = data.BodyData;
  const FormattedTxt = FormatSecondWindBody(BodyFill);
  let VertSize = 250;
  if (UIState === "SWReadMe") {
    VertSize = 400;
  } else if (!AmInTown) {
    VertSize = 300;
  }
  return (
    <Window
      title="Second Wind"
      width={400}
      height={VertSize}
      resizable>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <SecondWindTopBar />
          </Stack.Item>
          <Stack.Item grow>
            <Section
              fill
              scrollable>
              <Flex direction="row">
                <Flex.Item grow={1}>
                  <Box
                    width="auto"
                    mt={1}
                    mb={1}
                    textAlign="center">
                    <Icon
                      size={1.5}
                      color={BodyHeadIconColor}
                      name={BodyHeadIconImg} />
                  </Box>
                </Flex.Item>
                <Flex.Item shrink={1}>
                  <Box
                    fluid
                    bold
                    fontSize="1.5em"
                    textAlign="center"
                    mt={1}
                    mb={1}>
                    {BodyHead}
                  </Box>
                </Flex.Item>
                <Flex.Item grow={1} />
              </Flex>
              <Box fontSize="1pt">
                <hr />
              </Box>
              <Box
                dangerouslySetInnerHTML={FormattedTxt}
                fluid
                mb={1}
                mt={1} />
            </Section>
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
    AmInTown,
  } = data;
  const {
    PBarColors,
    TimeText,
    Percentage,
    TargTime,
    UltraFree,
  } = data.TimeData;
  const {
    DedPBarColors,
    DedTimeText,
    DedPercentage,
    DedTargTime,
    BonePBarColors,
    BoneTimeText,
    BonePercentage,
    BoneTargTime,
  } = data.DeadData;
  let LowCol = "bad";
  let MedCol = "average";
  let HighCol = "good";
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
    <Flex>
      <Flex.Item grow>
        {UltraFree
          ? (
            <Stack fill vertical>
              <Stack.Item>
                <ProgressBar
                  value={DedPercentage}
                  minValue={0}
                  maxValue={100}
                  ranges={{
                    good: [0, 100],
                  }}
                  color="good"
                  textAlign="center">
                  {DedTimeText}
                </ProgressBar>
              </Stack.Item>
              {/* {!AmInTown
                ? (
                  <Stack.Item>
                    <ProgressBar
                      value={BonePercentage}
                      minValue={0}
                      maxValue={100}
                      ranges={{
                        good: [0, 100],
                      }}
                      color="good"
                      textAlign="center">
                      {BoneTimeText}
                    </ProgressBar>
                  </Stack.Item>
                )
                : null} */}
              <Stack.Item>
                <ProgressBar
                  value={Percentage}
                  minValue={0}
                  maxValue={100}
                  ranges={{
                    LowCol: [0, 35],
                    MedCol: [35, 65],
                    HighCol: [65, 100],
                  }}
                  color="good"
                  textAlign="center">
                  {TimeText}
                </ProgressBar>
              </Stack.Item>
            </Stack>
          ) : (
            null
          )}
      </Flex.Item>
      {/* <Flex.Item shrink>
      </Flex.Item> */}
    </Flex>
  );
};

const SecondWindInfoButton = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
  } = data;
  let ActDo = 'GoReadme';
  let ButtonIcon = 'info';
  if (UIState === "SWReadMe") {
    ActDo = 'GoHome';
    ButtonIcon = 'times';
  }
  return (
    <Button
      icon={ButtonIcon}
      tooltip="Second Wind Info"
      onClick={() => act(ActDo)} />
  );
};

const FormatSecondWindBody = (Text2Format) => {
  const sanitizedText = sanitizeText(Text2Format);
  const formattedText = marked(sanitizedText, {
    smartypants: true,
    gfm: true,
    tables: true,
    sanitize: false,
    breaks: true,
    smartLists: true,
  });
  return { __html: formattedText };
};

const SecondWindBottomBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    ShowButtons,
    AmDead,
  } = data.BodyData;
  if (AmDead === false) {
    return null;
  }
  let ShowButtonOne = false;
  let ShowButtonTwo = false;
  let ButtonHeight = "0px";
  let Butt1width = "50%";
  let Butt2width = "50%";
  switch (ShowButtons) {
    case "OnlyRevive":
      ShowButtonOne = true;
      ButtonHeight = "2em";
      Butt1width = "100%";
      Butt2width = "0%";
      break;
    case "OnlyBack":
      ShowButtonTwo = true;
      ButtonHeight = "2em";
      Butt1width = "0%";
      Butt2width = "100%";
      break;
    case "Both":
      ShowButtonOne = true;
      ShowButtonTwo = true;
      ButtonHeight = "2em";
      Butt1width = "50%";
      Butt2width = "50%";
      break;
    default:
      ShowButtonOne = false;
      ShowButtonTwo = false;
      ButtonHeight = "0px";
      Butt1width = "0%";
      Butt2width = "0%";
      break;
  }
  return (
    <Box
      fluid
      // height={ButtonHeight}
      bold
      mb={1}>
      <Stack fill vertical>
        <Stack.Item>
          <Flex>
            <Flex.Item basis={Butt1width}>
              {!!ShowButtonOne && <SecondWindRevive Ht={ButtonHeight} />}
            </Flex.Item>
            <Flex.Item basis={Butt2width}>
              {!!ShowButtonTwo && <SecondWindBack Ht={ButtonHeight} />}
            </Flex.Item>
          </Flex>
        </Stack.Item>
        <Stack.Item>
          <Button
            fluid
            textAlign="center"
            onClick={() => act('HomewardBone')}>
            Return to Town
          </Button>
        </Stack.Item>
      </Stack>
    </Box>
  );
};

const SecondWindRevive = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
  } = data;
  const {
    Ht,
  } = props;
  let ButtonLabel = "Revive";
  let ButtonIcon = "heartbeat";
  if (UIState === "SWConfirm") {
    ButtonLabel = "Confirm";
    ButtonIcon = "check";
  }
  return (
    <Button
      color="good"
      fill
      fluid
      textAlign="center"
      height={Ht}
      onClick={() => act('ClickedRevive')}>
      <Icon
        size={1}
        color="white"
        name={ButtonIcon} />
      {ButtonLabel}
    </Button>
  );
};

const SecondWindBack = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UIState,
  } = data;
  const {
    Ht,
  } = props;
  let ButtonLabel = "Back";
  let ButtonIcon = "times";
  if (UIState === "SWConfirm") {
    ButtonLabel = "Cancel";
    ButtonIcon = "times";
  }
  return (
    <Button
      color="bad"
      fill
      fluid
      textAlign="center"
      height={Ht}
      onClick={() => act('GoHome')}>
      <Icon
        size={1}
        color="white"
        name={ButtonIcon} />
      {ButtonLabel}
    </Button>
  );
};
