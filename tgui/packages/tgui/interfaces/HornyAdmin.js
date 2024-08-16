/* eslint-disable react/no-danger */
// 80 characters is not big enough for my yiff yiff
/* eslint-disable max-len */
import { useBackend, useLocalState } from '../backend';
import { toFixed } from 'common/math';
import { multiline } from 'common/string';
import {
  AnimatedNumber,
  Box,
  Button,
  Divider,
  Dropdown,
  Input,
  Tooltip,
  Section,
  LabeledList,
  NoticeBox,
  NumberInput,
  Icon,
  Knob,
  Stack,
  Fragment,
  Table,
  TextArea,
  ToggleBox,
} from '../components';
import { formatMoney } from '../format';
import { Window } from '../layouts';
import { marked } from 'marked';
import { sanitizeText } from '../sanitize';

/*
  Welcome to HornyChat, how horny are you?
    I yiffed a bowl of nails for breakfast, without any milk.

  This is the preferecnes page for HornyChat, you can set your preferences here.
  There are three tabs, "Profile Pics", "Message Appearance", and "Preview".

  Profile Pics:
    Sevreral lines for profile pics
    Column names:
      - Copy
      - Message Mode
      - Host
      - Filename
      - Preview
      - Clear
    Each line will have:
      - A copy button
        - Will add in a paste button for the rest of the entries
      - The message mode that will trigger the profile pic
      - A dropdown for supported hosts
      - A text input for the image URL
      - A preview of the image (smol)
      - A clear button
    At the bottom of the list panel, there will be an extra row, for stock pics
    It'll have a button you can press, and it'll open a new window with a list of stock pics
    We'll get into that later.

  Message Appearance:
    This is where you set up the Geocities-style HTML gradient stuff.
    You can set up a gradient for the background of each of the boxes,
    as well as setup border colors, styles, and widths.
    Web 2.0? Never heard of it.
    Lots of tabs, lots of options.
    there are two columns!
      - Left column:
        The message modes, arranged vertically
        This will set a local state for the right column to display the options
        for the selected message mode!
        Each message mode will have a button to copy the settings to anothr mode
      - Right column:
        The rest of the damn owl
        This will have a bunch of options for the selected message mode
        as well as a preview of the message appearance
        It will be arranged in rows:
          - Which section of the message appearance to edit
          - The options for that section
          - A preview of the message appearance

  Preview:
    A list of preview messages, one for each message mode
    Each message will have a preview of the message appearance
    as well as an example message (worning: will contain horny)

  */

const BackMsgMode2Front = {
  "say": "Say",
  "custom_say": "Custom Say",
  "whisper": "Whisper",
  "whispercrit": "Whisper",
  "ask": "Ask",
  "exclaim": "Exclaim",
  "yell": "Yell",
  "%": "Sing", // CUS COURSE ITS %
  "emote": "Emote",
  "me": "Me",
};

// dark pale violet: #5F9EA0
// dark slate gray: #2F4F4F
// darker slate gray: #1F3A3A
// dark blue: #00008B
// dark olive green: #556B2F
// dark green: #006400
// dark red: #8B0000
// dark orange: #FF8C00
// dark goldenrod: #B8860B
// dark khaki: #BDB76B
// dark orchid: #9932CC
// dark violet: #9400D3
// dark magenta: #8B008B
// dark pink: #FF1493
// dark salmon: #E9967A
// dark tomato: #D30000
// dark coral: #FF7F50
// dark sienna: #8B4513
// dark brown: #5A2E2E
// dark chocolate: #D2691E
// dark purple: #800080
// dark indigo: #4B0082

// dark cyan: #008B8B
// dark sky blue: #8CBED6
// dark light blue: #8CBED6
// dark light green: #90EE90
// dark light red: #FF6347
// dark light orange: #FFA500
// dark light goldenrod: #DAA520
// dark light khaki: #F0E68C
// dark light orchid: #9932CC
// dark light violet: #9400D3
// dark light magenta: #EE82EE
// dark light pink: #FFB6C1
// dark light salmon: #E9967A
// dark light tomato: #FF6347
// dark light coral: #F08080
// dark light sienna: #A0522D
// dark light brown: #A52A2A
// dark light chocolate: #D2691E
// dark light purple: #9370DB
// dark light indigo: #4B0082

// dark light cyan: #008B8B
// dark light sky blue: #8CBED6
// dark light light blue: #8CBED6
// dark light light green: #90EE90
// dark light light red: #FF6347
// dark light light orange: #FFA500
// Thanks to https://www.colorhexa.com/ for the colors
// (I didnt actually use that site, I just like to thank random people)

const StupidDumbName = "VisualChat JanniPeep v1.0.0 (Trial Version) (EXPIRED!)";
const StupidProgram = "QuickShame PRO v2.6.8β";

// Whos a horny admin? You are! Yes you are!
export const HornyAdmin = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      width={900}
      height={600}
      title={StupidDumbName}
      theme="ntos"
      resizable>
      <Window.Content
        style={{
          "background": "linear-gradient(180deg, #2F4F4F, #1F3A3A)",
        }}>
        <Stack fill vertical>
          <Stack.Item>
            <UpperRowTabBar />
          </Stack.Item>
          <Stack.Item grow shrink> {/* grow shrink my beloved, you have saved so many of my garbo layouts */}
            <Section fill scrollable>
              <MainWindow />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <LowerRowBar />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const UpperRowTabBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserCKEY,
  } = data;

  return (
    <Section
      title={`Welcome to ${StupidProgram}, ${UserCKEY}!`}
      buttons={(
        // the JanniQuick button, to quickly go through everyone's preferences
        <Button
          icon="user-secret"
          content={`Begin ${StupidProgram}`}
          onClick={() => EngageJanniQuick(props, context)} />
      )}>
      {"Check and verify the appropriateness of everyone's profile pics and message appearances, live, over the internet!"}
      <Button // refresh
        icon="sync"
        position="absolute"
        right="0"
        bottom="0"
        content="Refresh"
        onClick={() => act('Refresh')} />
    </Section>
  );
};

const EngageJanniQuick = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    FullMonkey = [],
  } = data;

  const [
    ActiveMonkey,
    setActiveMonkey,
  ] = useLocalState(context, "ActiveMonkey", -1);

  setActiveMonkey(0);
};

// the next/prev buttons for the JanniQuick
const JanniQuickButtons = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    FullMonkey,
  } = data;

  const [
    ActiveMonkey,
    setActiveMonkey,
  ] = useLocalState(context, "ActiveMonkey", -1);

  const nextvalue = ActiveMonkey + 1 >= FullMonkey.length ? 0 : ActiveMonkey + 1;
  const prevvalue = ActiveMonkey - 1 < 0 ? FullMonkey.length - 1 : ActiveMonkey - 1;

  return (
    <Box
      my="auto">
      <Stack fill>
        <Stack.Item grow shrink>
          <Button
            fluid
            icon="arrow-left"
            disabled={ActiveMonkey < 0}
            content="Previous"
            onClick={() => setActiveMonkey(prevvalue)} />
        </Stack.Item>
        <Stack.Item shrink>
          <Box // ook
            width="auto">
            {
              ActiveMonkey < 0
                ? `Click next to begin ${StupidProgram}`
                : `${StupidProgram}: ${ActiveMonkey + 1} of ${FullMonkey.length}`
            }
          </Box>
        </Stack.Item>
        <Stack.Item grow shrink>
          <Button
            fluid
            icon="arrow-right"
            content="Next"
            onClick={() => setActiveMonkey(nextvalue)} />
        </Stack.Item>
      </Stack>
    </Box>
  );
};

const LowerRowBar = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <JanniQuickButtons />
  );
};

const MainWindow = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserCKEY,
    FullMonkey,
  } = data;

  const [
    ActiveMonkey,
    setActiveMonkey,
  ] = useLocalState(context, "ActiveMonkey", -1);

  if (ActiveMonkey < 0) {
    return (
      <MonkeyIndex />
    );
  } else {
    return (
      <MonkeyWindow />
    );
  }
};

const MonkeyIndex = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    FullMonkey = [],
  } = data;

  const [
    ActiveMonkey,
    setActiveMonkey,
  ] = useLocalState(context, "ActiveMonkey", -1);

  // ANATOMY OF THE FULL MONKEY
  // FullMonkey = [
  //   {
  //     PerpCKEY: "Tanhony",
  //     PerpName: "Mrs. Muggles",
  //     PerpImages: {
  //       say: {
  //         Host: "www.pissbucket.com/",
  //         URL: "pissbucket.png",
  //         Modifiable: true,
  //         CustomMessageVerb: "says,|whines,",
  //         CustomBlankVerb: "moans like a horny bottom in heat!!~",
  //       },
  //       (etc)
  //     },
  //     PerpSettings: {}, // unused
  //     PerpPreviewMessages: [
  //       {
  //         Mode: "say",
  //         Message: "<div>lots of stuff</div>",
  //       },
  //       (etc)
  //     ],
  //   },
  //   (etc)

  return (
    <Section
      title="JanniQuick Index">
      <Stack fill vertical>
        {FullMonkey.map((Monkey, index) => (
          <Stack.Item key={index}>
            <Button
              key={index}
              onClick={() => setActiveMonkey(index)} >
              {`${index + 1}. ${Monkey.PerpCKEY} (${Monkey.PerpName})`}
            </Button>
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};

const MonkeyWindow = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserCKEY,
    FullMonkey = [],
  } = data;

  const [
    ActiveMonkey,
    setActiveMonkey,
  ] = useLocalState(context, "ActiveMonkey", 0);

  // stores the admin's settings for each monkey
  const [
    MonkeySettings,
    setMonkeySettings,
  ] = useLocalState(context, {});

  const Monkey = FullMonkey[ActiveMonkey];

  return (
    <Section
      title={`${Monkey.PerpCKEY} (${Monkey.PerpName})`}>
      <Stack fill vertical>
        {Monkey.PerpPreviewMessages.map((PreviewMess, index) => (
          <Stack fill vertical key={index}>
            <Stack.Item>
              <PreviewMessage
                DisplayHTML={PreviewMess.Message} />
            </Stack.Item>
            <Stack.Item>
              <Stack fill>
                <Stack.Item grow>
                  <Button
                    icon="trash"
                    fluid
                    content="Reset Profile Pic"
                    onClick={() => act('ResetSingle', {
                      UserCkey: Monkey.PerpCKEY,
                      PerpCKEY: Monkey.PerpCKEY,
                      Mode: PreviewMess.Mode,
                      RstPic: true,
                    })} />
                </Stack.Item>
                <Stack.Item grow>
                  <Button
                    icon="trash"
                    fluid
                    content="Reset Verb"
                    onClick={() => act('ResetSingle', {
                      UserCkey: Monkey.PerpCKEY,
                      PerpCKEY: Monkey.PerpCKEY,
                      Mode: PreviewMess.Mode,
                      RstVerb: true,
                    })} />
                </Stack.Item>
                <Stack.Item grow>
                  <Button
                    icon="trash"
                    fluid
                    content="Reset Extended Verb"
                    onClick={() => act('ResetSingle', {
                      UserCkey: Monkey.PerpCKEY,
                      PerpCKEY: Monkey.PerpCKEY,
                      Mode: PreviewMess.Mode,
                      RstVerbBlank: true,
                    })} />
                </Stack.Item>
                <Stack.Item grow>
                  <Button
                    icon="trash"
                    fluid
                    content="Reset Appearance"
                    onClick={() => act('ResetSingle', {
                      UserCkey: Monkey.PerpCKEY,
                      PerpCKEY: Monkey.PerpCKEY,
                      Mode: PreviewMess.Mode,
                      RstSettings: true,
                    })} />
                </Stack.Item>
                <Stack.Item grow>
                  <Button
                    icon="trash"
                    fluid
                    content="Reset All"
                    onClick={() => act('ResetSingle', {
                      UserCkey: Monkey.PerpCKEY,
                      PerpCKEY: Monkey.PerpCKEY,
                      Mode: PreviewMess.Mode,
                      RstPic: true,
                      RstVerb: true,
                      RstBlank: true,
                      RstSettings: true,
                    })} />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Box
              as="h1"
              mt={1}>
              <Divider />
            </Box>
          </Stack>
        ))}
      </Stack>
    </Section>
  );
};

// the preview message, the whole banana
const PreviewMessage = (props, context) => {
  const {
    DisplayHTML,
  } = props;

  return (
    <Box>
      <div
        dangerouslySetInnerHTML={{
          __html: DisplayHTML,
        }} />
    </Box>
  );
};




