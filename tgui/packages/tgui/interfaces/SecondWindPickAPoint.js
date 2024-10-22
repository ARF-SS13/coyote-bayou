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
  Welcome to Second Wind, how horny are you?
  This is just a smol window that'll let you pick somewhere to spawn in.
*/


export const SecondWindPickAPoint = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      width={400}
      height={500}
      title="VisualChat Preferences"
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

  return (
    <Box>
      To where would you like to punt your corpse?
    </Box>
  );
};

const MainWindow = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Bonfires,
  } = data;

  if (!Bonfires || Bonfires.length === 0) {
    return (
      <Box>
        Nowhere! Your stuck here forever! Tell Fenny to add some bonfires!
      </Box>
    );
  }

  return (
    <Stack fill vertical>
      {Bonfires.map((bonfire, index) => (
        <BonfireListing bonfire={bonfire} key={index} />
      ))}
    </Stack>
  );

};

const LowerRowBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserCKEY,
    SeeOthers,
    SeeRadio,
    AutoContrast,
  } = data;

  return (
    <Box />
  );
};

const BonfireListing = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    bonfire,
  } = props;
  const {
    BFName,
    BFTown,
    BFActive,
    BFCoords,
    BFFlavor,
    BFTag,
    BFspacer,
  } = bonfire;

  if (BFspacer) {
    return (
      <Box>
        <Divider />
      </Box>
    );
  }

  return (
    <Section
      title={`${BFName} (${BFActive ? "Active" : "Inactive"})`}
      buttons={(
        <Button
          icon="fire"
          content="Go!"
          onClick={() => act('PickTag', {
            BFTagReturn: BFTag,
          })} />
      )}>
      <Stack fill vertical>
        <Stack.Item>
          <Stack fill>
            <Stack.Item>
              <Box pr={1}>
                Region: {BFTown}
              </Box>
            </Stack.Item>
            <Stack.Item>
              <Box pr={1}>
                Coordinates: {BFCoords}
              </Box>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Box fontSize="75%" color="label">
            {BFFlavor}
          </Box>
        </Stack.Item>
      </Stack>
    </Section>
  );
};











