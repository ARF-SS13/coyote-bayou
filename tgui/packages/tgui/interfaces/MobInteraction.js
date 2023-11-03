/* eslint-disable max-len */
import { filter, map, sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { clamp } from 'common/math';
import { createSearch } from 'common/string';
import { useBackend, useLocalState } from '../backend';
import { BlockQuote, Button, Flex, Fragment, LabeledList, Icon, Input, Section, Table, Tabs, Stack, ProgressBar, Divider, Box } from '../components';
import { TableCell, TableRow } from '../components/Table';
import { Window } from '../layouts';


const tabcolor = [
  "default",
  "pink",
  "red",
  "yellow",
];

// Master holder of the interaction something such
// Includes panels for:
//   - NOT-MERP buttons (Non-Optional Touching of My Erotic Regions, Paul)
//   - Both your and their NADs (Naughty Action Devices)
//   - LUST readout (Lewd Unit of Sexual Tension)
//   - the CUM button (Climactic Unloading Mechanism)
//   - ConSENT status (Concurrent Sexual Engagement Negotiation Treaty)
//   - AutoPLAPs (Automatic Pre-Loaded Action Presets)
export const MobInteraction = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    LewdMode,
  } = data;
  const WindoHight = LewdMode ? 700 : 400;
  const BottomPanelHeight = LewdMode ? "50%" : "100%";

  return (
    <Window
      width={430}
      height={WindoHight}
      resizable>
        <Window.Content>
          <Flex direction="column">
            {LewdMode && (
              <Flex.Item basis="50%">
                <TopPanel /> {/* The lewd stuff */}
              </Flex.Item>
            )}
            <Flex.Item basis={LewdMode}>
              <BottomPanel />
            </Flex.Item>
          </Flex>
        </Window.Content>
    </Window>
  );
};

// the top panel! Provides a framework for:
//   - Your and their NADs
//   - LUST
//   - ConSENT status
//   - AutoPLAPs
const TopPanel = (props, context) => {
  const { act, data } = useBackend(context);

  return(
    <Box>
      <Stack fill>
        <Stack.Item grow> {/* Left Panel */}
          <Stack fill vertical>
            <Stack.Item>
              <Stack fill>
                <Stack.Item grow>
                  <Nads Who={"me"}/>
                </Stack.Item>
                <Stack.Item>
                  <Nads Who={"them"}/>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item grow>
              <Consent />
            </Stack.Item>
            <Stack.Item>
              <Lust />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item> {/* Right Panel */}
          <AutoPLAPs />
        </Stack.Item>
      </Stack>
    </Box>
  );
};

// The NADs panel! Has two parts: Your NADs and Their NADs
// Its a series of icons that give a tooltip that shows your and their
// naughty bits, and their various details. Things like visibility, arousal,
// size, shape, etc. Also has a button to open your private panel to mess with
// them. Also includes a group of emojis that show their top/bottomness,
// who they like to kiss, and such.
const Nads = (props, context) => {
  const { act, data } = useBackend(context);
  const GenitalObjs =
    props.Who === "me"
    ? data.MyGenitals
    : data.TheirGenitals
    || [];
  const OritentationObjs =
    props.Who === "me"
    ? data.MyOrientations
    : data.TheirOrientations
    || [];
  const NameShow =
    props.Who === "me"
    ? "Your NADs"
    : data.TheirName + "'s NADs"
  const NadName =
    props.Who === "me"
    ? "Your"
    : data.TheirName + "'s"

  return(
    <Section title={NameShow}>
      {GenitalObjs.length ? (
        <Flex direction="column">
          {GenitalObjs.map(genital => (
            GuntButton(genital, NadName)
          ))}
        </Flex>
      ) : (
        "Nothing there!"
      )}
      <hr />
      {OritentationObjs.length ? (
        <Flex direction="column">
          {OritentationObjs.map(orientation => (
            OrientationButton(orientation)
          ))}
        </Flex>
      ) : (
        "Unsure!"
      )}
    </Section>
  );
};

// The consent panel! Shows if you and them are consenting to lewd things
// with each other. Exists as a button that when clicked requests consent.
// If clicked again, it will revoke consent!
const Consent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    PartnerCKEY,
    WeConsent,
  } = data;
  const ButtText = WeConsent ? "Consenting!" : "Not Consenting!";
  const ButtColor = WeConsent ? "green" : "default";
  const ButtHoverText = WeConsent ? "Revoke Consent?" : "Request Consent?";
  const ButtHoverColor = WeConsent ? "red" : "green";

  return(
    <Button
      fluid
      mb={0.3}
      content={ButtText}
      color={ButtColor}
      tooltip={ButtHoverText}
      tooltipPosition="right"
      onClick={() => act('ConsentAct', {
        who: PartnerCKEY,
      })} />
  );
};

// The LUST panel! Has settings for your sensitivity, autocum switch, projected
// time to cum when autoplap is happening, your and their current LUST levels,
// and a big cool button to make you CUM!
const Lust = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    MyLust,
    TheirLust,
    ItsJustMe,
    Sensitivity,
    MTTC, // Mean Time To Cum
    CurrLust,
    MaxLust,
    CanCum,
    MyName,
    TheirName,
  } = data;

  // dark lusty purple
  const LustBGColor = "#4B0082";
  // bright lusty pink
  const LustFGColor = "#FF00FF";

  const CumButtonText = CanCum ? "!! C U M !!" : "Can't Cum!";

  return(
    <Section>
      <Stack fill vertical>
        <Stack.Item> {/* settings */}
          <Box>
            <Flex direction="row">
              <Flex.Item grow={1}>
                Lust Sensitivity:
              </Flex.Item>
              <Flex.Item basis="5rem">
                <Input
                  value={Sensitivity}
                  width="5rem"
                  onInput={(e, value) => act('Sensitivity', {
                    value: clamp(value, 0, 100),
                  })} />
              </Flex.Item>
            </Flex>
            <Flex direction="row">
              <Flex.Item grow={1}>
                Mean Time To Cum:
              </Flex.Item>
              <Flex.Item basis="5rem">
                <Input
                  value={MTTC}
                  width="5rem"
                  onInput={(e, value) => act('MTTC', {
                    value: clamp(value, 0, 10000),
                  })} />
              </Flex.Item>
            </Flex>
            <Flex direction="row">
              <Flex.Item grow={1}>
                Current Lust:
              </Flex.Item>
              <Flex.Item basis="5rem">
                <Input
                  value={CurrLust}
                  width="5rem"
                  onInput={(e, value) => act('CurrLust', {
                    value: clamp(value, 0, MaxLust),
                  })} />
              </Flex.Item>
            </Flex>
            <Flex>
              <Flex.Item grow={1}>
                Max Lust:
              </Flex.Item>
              <Flex.Item basis="5rem">
                <Input
                  value={MaxLust}
                  width="5rem"
                  onInput={(e, value) => act('MaxLust', {
                    value: clamp(value, 0, 100000),
                  })} />
              </Flex.Item>
            </Flex>
            <hr />
            <Stack fill> {/* Lust! Both ours and their (if they arent us) */}
              <Stack.Item>
                <Table>
                  <Table.Row>
                    <Table.Cell>
                      {MyName}
                    </Table.Cell>
                    {!!ItsJustMe ? (
                      <Table.Cell>
                        {MyName} {/* Nobody's here but you and your hand~ */}
                      </Table.Cell>
                    ) : (
                      <Table.Cell>
                        {TheirName}
                      </Table.Cell>
                    )}
                  </Table.Row>
                  <Table.Row>
                    <Table.Cell>
                      <ProgressBar
                        value={MyLust}
                        color={LustBGColor}
                        minValue={0}
                        maxValue={MaxLust} >
                        <Box inline color={LustFGColor}>
                          {MyLust}
                        </Box>
                      </ProgressBar>
                    </Table.Cell>
                    {!!ItsJustMe ? (
                      <Table.Cell>
                        <ProgressBar
                          value={MyLust}
                          color={LustBGColor}
                          minValue={0}
                          maxValue={MaxLust} >
                          <Box inline color={LustFGColor}>
                            {MyLust}
                          </Box>
                        </ProgressBar>
                      </Table.Cell>
                    ) : (
                      <Table.Cell>
                        <ProgressBar
                          value={TheirLust}
                          color={LustBGColor}
                          minValue={0}
                          maxValue={MaxLust} >
                          <Box inline color={LustFGColor}>
                            {TheirLust}
                          </Box>
                        </ProgressBar>
                      </Table.Cell>
                    )}
                  </Table.Row>
                </Table>
              </Stack.Item>
              <Stack.Item shrink={1}>
                <Button
                  fluid
                  mb={0.3}
                  disabled={!CanCum}
                  color="pink"
                  content={CumButtonText}
                  bold={CanCum}
                  onClick={() => act('Cum')} />
              </Stack.Item>
            </Stack>
          </Box>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// The AutoPLAPs panel! Holds a list of all your active autoPLAPpers, which
// hold the interaction key its using, the interval of its firing, whether or
// not its active, a pause button, a delete button, an edit button, who its
// PLAPping, and whether or not its PLAPping this current dork.
// Also has a toggle at the bottom for whether or not it'll automatically start
// when a new autoPLAP is made
const AutoPLAPs = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AutoPlapObjs,
    AutoPlapAutoStart,
    PartnerCKEY,
  } = data;

  const YesOrNo = AutoPlapAutoStart ? "YES" : "NO";

  return(
    <Section
      title="Auto-Interactors"
      buttons={(
        <Fragment>
          <Button
            icon={"pause"}
            onClick={() => act('StopAllAutoPlappers')} />
          <Button
            icon={"play"}
            onClick={() => act('StartAllAutoPlappers')} />
        </Fragment>
      )}>
      <Flex direction="row">
        <Flex.Item grow={1}>
          {AutoPlapObjs.length ? (
            <Stack fill vertical>
              {AutoPlapObjs.map(autoPlap => (
                <Stack.Item key={autoPlap.key}>
                  <AutoPLAP
                    autoPlap={autoPlap} />
                </Stack.Item>
              ))}
            </Stack>
          ) : (
            "To add some, click the red dot by an interaction!"
          )}
        </Flex.Item>
        <Flex.Item shrink={1}>
          <Button
            fluid
            mb={0.3}
            content={"Auto-Start: " + YesOrNo}
            color={AutoPlapAutoStart ? "green" : "default"}
            onClick={() => act('ToggleAutoStart')} />
        </Flex.Item>
      </Flex>
    </Section>
  );
};


























/// GuntButton! Takes in a genital object thing, and formats it into a button
/// that shows a tooltip about the genital
const GuntButton = (genital, NadName) => {
  const {
    Name,
    Size,
    Shape,
    Arousal,
    CanArouse,
    Emoji,
    Ref,
  } = genital || {
    Name: "Nothing",
    Size: "Unknown",
    Shape: "Unknown",
    Arousal: "Unknown",
    CanArouse: "Unknown",
    Emoji: ":(",
    Ref: null,
  };

  return(
    <Button
      key={Name}
      icon={Emoji}
      tooltip={
        NadName + " " + Name + "\n" +
        Size + "\n" +
        Shape + "\n" +
        Arousal + "\n" +
        CanArouse + "\n"
      }
      onClick={() => act('poke', {
        interaction: "poke",
        genital: Name,
      })} />
  );
};

/// OrientationButton! Takes in an orientation object thing, and formats it into a button
/// that shows a tooltip about the orientation
const OrientationButton = (orientation) => {
  const {
    Name,
    Emoji,
  } = orientation || {
    Name: "Non-aligned",
    Emoji: ":(",
  };

  return(
    <Button
      key={Name}
      icon={Emoji}
      tooltip={Name} />
  );
};


