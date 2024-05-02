/* eslint-disable */
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import {
  Box,
  Button,
  Icon,
  LabeledList,
  Flex,
  Section,
  Table,
  Stack,
  Tabs } from '../components';
import { Window } from '../layouts';
import { marked } from 'marked';
import { sanitizeText } from '../sanitize';

export const CharacterInspection = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    gender,
    species,
    vorepref,
    erppref,
    kisspref,
    flink,
    ad,
    notes,
    flavor,
    their_quid,
    viewer_quid,
    name,
    looking_for_friends,
  } = data;

  const [
    SelectedTab,
    setSelectedTab,
  ] = useLocalState(context, 'SelectedTab', 1);

  return (
    <Window
      width={580}
      height={640}
      resizable
      title={`${name} the ${species} (${gender})`}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Section
              title={`${name} the ${species} (${gender})`}
              smallTitle={true}
              buttons={(true
                && <>
                  Say&nbsp;Hi!&nbsp;--&gt;&nbsp;&nbsp;&nbsp;
                  <Button
                    onClick={() => act("pager", {
                      their_quid: their_quid,
                      viewer_quid: viewer_quid,
                    })}
                    icon="envelope"
                    tooltip="Send a message to this character!"
                    mr={1} />
                  </>
              )} >
              <ERPPref />
              <VorePref />
              <KissPref />
              <FlistLink />
            </Section>
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
                Flavor Text
              </Tabs.Tab>
              <Tabs.Tab
                selected={SelectedTab === 2}
                onClick={() => {
                  setSelectedTab(2);
                  act('JustUpdate');
                }}>
                OOC Notes
              </Tabs.Tab>
              <Tabs.Tab
                selected={SelectedTab === 3}
                onClick={() => {
                  setSelectedTab(3);
                  act('JustUpdate');
                }}>
                Extra Info
              </Tabs.Tab>
              {/* <Tabs.Tab
                selected={SelectedTab === 4}
                onClick={() => {
                  setSelectedTab(4);
                  act('JustUpdate');
                }}>
                Gallery (SFW)
              </Tabs.Tab>
              <Tabs.Tab
                selected={SelectedTab === 5}
                onClick={() => {
                  setSelectedTab(5);
                  act('JustUpdate');
                }}>
                Gallery (NSFW)
              </Tabs.Tab> */}
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

// / The main window! either your characters or the available characters
const MainWindow = (props, context) => { // main screen turn on
  const { act, data } = useBackend(context);

  const [
    SelectedTab,
    setSelectedTab,
  ] = useLocalState(context, 'SelectedTab', 1);
  /// check if data.profile_pic contains what is liokely a URL
  const isURL = (data.profile_pic && data.profile_pic.match(/^(http|https):\/\//));


  return (
    <>
      {SelectedTab === 1 && (
        <Box>
          {isURL && data.profile_pic ? (
            <Box textAlign="center">
              <Button
                color="transparent"
                tooltip="View this character's profile picture!"
                onClick={() => act("show_pic", {
                    their_quid: data.their_quid,
                    viewer_quid: data.viewer_quid,
                  })}>
                <Box
                  as="img"
                  height="65vh"
                  src={data.profile_pic}
                  alt="Imagine a cool image here!"
                  width="100%"
                  style={{
                    "objectFit": 'contain',
                    "maxHeight": '65vh',
                  }}
                  />
              </Button>
            </Box>
          ) : (
            <Fragment />
          )}
          <Section title="Flavor Text">
            <Box
              style={{
                "whiteSpace": 'pre-wrap',
              }}
              dangerouslySetInnerHTML={Text2HTML(data.flavor)}
              />
          </Section>
        </Box>
      )
      || SelectedTab === 2 && (
        <Section title="OOC Notes">
          <Box dangerouslySetInnerHTML={Text2HTML(data.notes)} />
        </Section>
      )
      || SelectedTab === 3 && (
        <Section title="Extra Info">
          <Box dangerouslySetInnerHTML={Text2HTML(data.ad)} />
        </Section>
      )
      // || SelectedTab === 4 && (
      //   <Section title="Gallery (SFW)">
      //     <Gallery SFW={1} />
      //   </Section>
      // )
      // || SelectedTab === 5 && (
      //   <Section title="Gallery (NSFW)">
      //     <Gallery SFW={0} />
      //   </Section>
      // ) // coming soon: these
      }
    </>
  );
};

// / The bottom toolbar
const BottomToolbar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    looking_for_friends,
    their_quid,
    viewer_quid,
  } = data;

  return (
    <Box mx={1} mt={1} textAlign="center">
      {
        true
          ? looking_for_friends ? (
            <Button
              onClick={() => act("pager", {
                their_quid: their_quid,
                viewer_quid: viewer_quid,
              })}
              tooltip="They're looking for a friend! Send them a message!"
              mr={1}>
              Looking for friends! --&gt;&nbsp;&nbsp;&nbsp;
              <Icon name="envelope" size={2} />
              &lt;-- Send me a message!
            </Button>
          ) : (
            <Button
              onClick={() => act("pager", {
                their_quid: their_quid,
                viewer_quid: viewer_quid,
              })}
              color="transparent"
              icon="envelope-circle-check"
              tooltip="Send a message to this character!"
              mr={1} />
          )
          : <Box />
      }
    </Box>
  );
};

// / The ERP Preference
const ERPPref = (props, context) => {
  const { act, data } = useBackend(context);
  const { erppref } = data;

  return (
    <Button
      icon="heart"
      tooltip="Is this person into ERP, and if so, are they a top, bottom, or switch?"
      tooltipPosition="bottom"
      textAlign="center"
      color="transparent"
      mr={1}>
      {erppref}
    </Button>
  );
};

// / The Vore Preference
const VorePref = (props, context) => {
  const { act, data } = useBackend(context);
  const { vorepref } = data;

  return (
    <Button
      icon="drumstick-bite"
      tooltip="Is this person into vore, and if so, what kind?"
      tooltipPosition="bottom"
      textAlign="center"
      color="transparent"
      mr={1}>
      {vorepref}
    </Button>
  );
};

// / The Kiss Preference
const KissPref = (props, context) => {
  const { act, data } = useBackend(context);
  const { kisspref } = data;

  return (
    <Button
      icon="kiss"
      tooltip="What sort of person this person likes to kiss!"
      tooltipPosition="bottom"
      textAlign="center"
      color="transparent"
      mr={1}>
      {kisspref}
    </Button>
  );
};

// / The F-list link
const FlistLink = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    flink,
    their_quid,
    viewer_quid,
  } = data;

  return (
    flink && (
      <Button
        onClick={() => act("view_flist", {
          their_quid: their_quid,
          viewer_quid: viewer_quid,
        })}
        content="F-List"
        color="transparent"
        icon="link"
        tooltip="View this character's F-List (if any)!"
        tooltipPosition="bottom"
        disabled={!flink}
        mr={1} />
    )
  );
};

// / Sanitizes and marks up text
const Text2HTML = (text) => {
  // Default values
  let coolTags = [
    'b',
    'br',
    'center',
    'code',
    'div',
    'font',
    'hr',
    'i',
    'li',
    'menu',
    'ol',
    'p',
    'pre',
    'table',
    'td',
    'th',
    'tr',
    'u',
    'ul',
  ];
  let uncoolAttr = ['class', 'style'];

  const sanitizedText = sanitizeText(text, coolTags, uncoolAttr);
  const formattedText = marked(sanitizedText, { smartypants: true, gfm: true, tables: true, sanitize: false, breaks: true, smartLists: true });
  return { __html: formattedText };
};
