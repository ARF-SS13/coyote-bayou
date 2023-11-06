/* eslint-disable max-len */
import { filter, map, sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { clamp } from 'common/math';
import { createSearch } from 'common/string';
import { useBackend, useLocalState } from '../backend';
import { Button, Flex, Fragment, LabeledList, Icon, Input, Section, Table, NoticeBox, Stack, ProgressBar, Box } from '../components';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';


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

  return (
    <Window
      width={600}
      height={WindoHight} // i know what I did
      resizable>
      <Window.Content>
        <Stack fill vertical>
          {!!LewdMode && (
            <Stack.Item shrink={1}>
              <TopPanel /> {/* The lewd stuff */}
            </Stack.Item>
          )}
          <Stack.Item grow={1}>
            <BottomPanel /> {/* The not-lewd stuff */}
          </Stack.Item>
        </Stack>
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
  const {
    ItsJustMe,
  } = data;

  return(
    <Box>
      <Stack fill>
        <Stack.Item basis="50%"> {/* Left Panel */}
          <Stack fill vertical>
            <Stack.Item>
              <Stack fill>
                <Stack.Item grow>
                  <Nads Who={"me"}/>
                </Stack.Item>
                {!ItsJustMe && (
                  <Stack.Item>
                    <Nads Who={"them"}/>
                  </Stack.Item>
                )}
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
        <Stack.Item basis="50%"> {/* Right Panel */}
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
    TheirCKEY,
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
        who: TheirCKEY,
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
    MyMaxLust,
    TheirLust,
    TheirMaxLust,
    ItsJustMe,
    MTTC, // Mean Time To Cum
    CanCum,
    MyName,
    TheirName,
  } = data;

  // dark lusty purple
  const LustBGColor = "#4B0082";
  // bright lusty pink
  const LustFGColor = "#FF00FF";

  const CumButtonText = "!! C U M !!";
  const AutocumText = CanCum ? "Autocum: ON" : "Autocum: OFF";
  const AutocumColor = CanCum ? "green" : "default";

  return(
    <Section>
      {/* <Flex direction="row"> todo: makr it work
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
      </Flex>*/}
      {/* <Flex direction="row">
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
      <hr />*/}
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
              maxValue={MyMaxLust} >
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
                maxValue={MyMaxLust} >
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
                maxValue={TheirMaxLust} >
                <Box inline color={LustFGColor}>
                  {TheirLust}
                </Box>
              </ProgressBar>
            </Table.Cell>
          )}
        </Table.Row>
      </Table>
      <Stack fill>
        <Stack.Item grow={1}>
          <Button
            fluid
            mb={0.3}
            color={AutocumColor}
            content={AutocumText}
            bold={CanCum}
            onClick={() => act('ToggleAutoCum')} />
        </Stack.Item>
        <Stack.Item grow={1}>
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
  } = data;

  const YesOrNo = AutoPlapAutoStart ? "YES" : "NO";

  return(
    <Stack fill vertical>
      <Stack.Item grow={1}>
        <Section
          title="Auto-Interactors"
          overflowY="auto"
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
          {AutoPlapObjs.length ? (
            <Stack fill vertical>
              {AutoPlapObjs.map(autoPlap => (
                <Stack.Item key={autoPlap.key} shrink={1}>
                  <AutoPlapControl AutoPlapObj={autoPlap} />
                </Stack.Item>
              ))}
            </Stack>
          ) : (
            "To add some, click the red dot by an interaction!"
          )}
        </Section>
      </Stack.Item>
      <Stack.Item shrink={1}>
        <Button
          fluid
          mb={0.3}
          content={"Auto-Start: " + YesOrNo}
          color={AutoPlapAutoStart ? "green" : "default"}
          onClick={() => act('ToggleAutoStart')} />
      </Stack.Item>
    </Stack>
  );
};

// An AutoPLAPper! A small panel that lists the automatic interactions that
// you have set up. It also comes with a control panel that lets you edit,
// pause, or delete the autoPLAPper. It takes in an autoPLAPper object, and
// spits out a panel with a bunch of info about it.
// Will some day have a progress bar that fills up as the autoPLAPper
// approaches its next firing. Some day~
const AutoPlapControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AutoPlapObj,
  } = props;
  const {
    APApid, // The unique ID that the parent uses to identify this one
    APPlapKey, // The key of the interaction that this autoPLAPper is using
    APPlapName, // The name of the interaction that this autoPLAPper is using
    APPlapper, // The ckey of the person is doing the PLAPping
    APPartner, // The ckey of the person being PLAPped
    APPlapperName, // The name of the person is doing the PLAPping
    APPartnerName, // The name of the person being PLAPped
    APInterval, // The interval of the PLAPping, in deciseconds
    APPlapping, // Whether or not the PLAPping is active
    APPlapcount, // How many times the PLAPping has happened
    APRecording, // If this is recording, meaning its still in its setup phase
  } = AutoPlapObj;

  const APPlappingIcon = APPlapping ? "pause" : "play";
  const APPlapColor = APPlapping ? "green" : "default";
  const APRecordingIcon = APRecording ? "ban" : "circle";
  const APRecordingColor = APRecording ? "red" : "red"; // red and also red

  const MyPartner = APPlapper === APPartner ? "Yourself" : APPartnerName;

  return(
    <Section
      title={APPlapName}
      buttons={(
        <Fragment>
          {APRecording && (
            <Button
              icon={APRecordingIcon}
              color={APRecordingColor}
              onClick={() => act('StopRecording', {
                APID: APApid,
              })} />
          )}
          <Button
            icon="trash"
            onClick={() => act('DeleteAutoPlapper', {
              APID: APApid,
            })} />
        </Fragment>
      )}>
      <Stack fill vertical>
        <Stack.Item>
          <Flex direction="column">
            <Flex.Item grow={1}>
              <Input
                value={APInterval}
                onInput={(e, value) => act('SetAutoPlapperInterval', {
                  APID: APApid,
                  Interval: clamp(value, 0, 300), // 30 seconds
                })} />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                icon={APPlappingIcon}
                color={APPlapColor}
                onClick={() => act('ToggleAutoPlapper', {
                  APID: APApid,
                })} />
            </Flex.Item>
          </Flex>
        </Stack.Item>
        <Stack.Item>
          <LabeledList>
            <LabeledList.Item label="Interacting with:">
              {MyPartner}
            </LabeledList.Item>
            <LabeledList.Item label="You've done this:">
              {APPlapcount} times!
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

/// GuntButton! Takes in a genital object thing, and formats it into a button
/// that shows a tooltip about the genital
const GuntButton = (genital, NadName) => {
  const {
    BitKind,
    BitName,
    BitSize,
    BitColor,
    BitAroused,
    BitExtra,
    BitEmoji,
  } = genital || {
    BitKind: "muffin",
    BitName: "Tuffy",
    BitSize: "Small",
    BitColor: "#FFFFFF",
    BitAroused: false,
    BitExtra: "Minty",
    BitEmoji: ":)",
  };

  const ArousedText = BitAroused ? "Happens to be aroused" : "Happens to not be Aroused";
  const ToolTipText =
    BitName + "\n" +
    BitSize + "\n" +
    ArousedText + "\n" +
    BitExtra + "\n";

  return(
    <Button
      tooltip={ToolTipText}
      content={BitEmoji}
      color={BitColor}
      onClick={() => act('interact', {
        interaction: "poke",
        ExtraStuff: {
          PokeThing: BitName,
        },
      })} />
  );
};

/// OrientationButton! Takes in an orientation object thing, and formats it into a button
/// that shows a tooltip about the orientation
const OrientationButton = (orientation) => {
  const {
    OriName,
    OriDesc,
    OriEmoji,
  } = orientation || {
    OriName: "Non-aligned",
    OriDesc: "I'm cool beans",
    OriEmoji: ":(",
  };

  return(
    <Button
      content={OriEmoji}
      color="green"
      tooltip={OriName + "\n" + OriDesc} />
  );
};


const FavePlaps = 'Favorites';
const PlapsPerPage = 10;

// The bottom panel! Provides a framework for:
//   - NOT-MERP buttons
//   - Favorited NOT-MERPs
//   - Searchable NOT-MERPs
//   - NOT-MERP categories
//   - Tabs for NOT-MERPs and easy-access prefs
//   - Toggle Button for Lewd Mode
const BottomPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserName,
  } = data;
  const AllInteractions = data.AllInteractions || [];
  const AllCategories = data.AllCategories || [];
  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', FavePlaps);
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const Cat2Use = SearchTerm ? AllInteractions[0] : SelectedCategory;
  const FilteredAllInteractions = GetInteractionsInCategory(Cat2Use, context);
  const WhyIsItEmpty = SearchTerm
    ? "No interactions found!"
    : SelectedCategory === AllInteractions[0]
      ? "Congratulations! You've been selected to open an issue on Github!"
      : "No interactions in this category!";

  return (
    <Box
      height="100%"
      width="100%">
      <Stack fill vertical>
        <Stack.Item>
          <Section
            width="100%"
            title={"Welcome, " + UserName + "!"}
            buttons={(
              <InteractionSearchBar />
            )} />
        </Stack.Item>
        <Stack.Item grow={1} basis={1}>
          <Section
            fill
            width="100%"
            scrollable>
            <Flex direction="row">
              <Flex.Item shrink={0}>
                <InteractionCategoryList />
              </Flex.Item>
              <Flex.Item grow={1} basis={0}>
                <InteractionJizz InteractionsInCat={FilteredAllInteractions} />
              </Flex.Item>
            </Flex>
          </Section>
        </Stack.Item>
        <Stack.Item>
          <InteractionPage />
        </Stack.Item>
      </Stack>
    </Box>
  );
};


// The search bar at the top of the window.
// Its a search bar! You can look up anything, so long as its the name
// of an interaction. or dragon pussy. I've promised it across like 3 PRs now,
// Ive gotta deliver at some point.
const InteractionSearchBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AllInteractions,
    DP,
  } = data;
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const FillerText = DP ? "Dragon Pussy" : "Find-A-Plap 0.1b (tm)";

  return (
    <Box inline width="fit-content">
      <Input
        width="15em"
        placeholder={FillerText}
        value={SearchTerm}
        onInput={(e, value) => {
          Searchificate(sanitizeText(value), context);
        }} />
    </Box>
  );
};

// Does some search bar stuff
const Searchificate = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AllCategories,
  } = data;
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', FavePlaps);
  const [
    CurrentPage,
    setCurrentPage,
  ] = useLocalState(context, 'CurrentPage', 1);

  if (SearchTerm.length > 0) {
    setCurrentPage(1);
    setSelectedCategory(AllCategories[0]);
  }
  setSearchTerm(props);
  // act('Sound', { 'DoSound': 'SearchType' });
};

// The big holder of the categories! Its a long column of tabs that
// you can click on to select a category. The categories are defined
// in AllInteractions, and the selected category is stored in the local state.
const InteractionCategoryList = (props, context) => {
  const { act, data } = useBackend(context);
  const AllCategories = data.AllCategories || [];
  const Firstie = AllCategories[0] || 'Oh no';
  const AllcatsMinusTheFirst = AllCategories.slice(1);
  const AllerCats = [Firstie, FavePlaps].concat(AllcatsMinusTheFirst); // surgery

  return (
    <Box
      p="0.5rem"
      mr="0.5rem"
      width="fit-content"
      backgroundColor="#2f2f2f">
      {AllerCats.map(category => (
        <InteractionTab CatName={category} key={category} />
      ))}
    </Box>
  );
}; // not that big of a proc actually

// One of the tabs in the category list. Its a tab! It has a name!
const InteractionTab = (props, context) => {
  const { act, data } = useBackend(context);
  const CatName = props.CatName || "Oh no";

  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', FavePlaps);
  const [
    CurrentPage,
    setCurrentPage,
  ] = useLocalState(context, 'CurrentPage', 1);
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');

  return (
    <Button
      key={CatName}
      fluid
      px="0.5em"
      py="0.25em"
      selected={SelectedCategory === CatName}
      onClick={() =>
      { setSelectedCategory(CatName);
        setCurrentPage(1);
        setSearchTerm('');
        /* act('Sound', {
          'DoSound': 'TabClick',
        });  */}}>
      <Box
        inline
        textAlign="center">
        {CatName}
      </Box>
    </Button>
  );
};

// The big holder of the plaps! Its a long column of big cool buttons
// that you can click on to select a plap. The plaps are defined
// in AllInteractions, and any selected plaps are defined in UserInteractions.
// the current category is stored in the local state.
// the category defines what interactions to show.
// If the category is AllInteractions[0],
// it will show all the quirks in AllInteractions.
const InteractionJizz = (props, context) => {
  const { act, data } = useBackend(context);
  const AllCategories = data.AllCategories || [];

  const [
    CurrentPage,
    setCurrentPage,
  ] = useLocalState(context, 'CurrentPage', 1);

  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');

  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', FavePlaps);

  const FilteredAllInteractions = GetInteractionsInCategory(SelectedCategory, context);


  const ShowRange = [CurrentPage * PlapsPerPage - PlapsPerPage, CurrentPage * PlapsPerPage];
  const ShowInteractions = FilteredAllInteractions.slice(ShowRange[0], ShowRange[1]);

  const WhyIsItEmpty = SearchTerm
    ? "No interactions found!"
    : SelectedCategory === AllCategories[0]
      ? "Congratulations! You've been selected to open an issue on Github! Use the keyword 'Dragon Pussy' for 15% off your tech support!"
      : "No interactions in this category!";

  return (
    <Box>
      {ShowInteractions.length === 0 && (
        <NoticeBox active>
          {WhyIsItEmpty}
        </NoticeBox>
      )}

      {ShowInteractions.map(Plap => (
        <Box
          key={Plap}
          mr="0.5em"
          mb="0.5em">
          <InteractionButton IOBJ={Plap} />
        </Box>
      ))}
    </Box>
  );
};

// One of the buttons in the Interaction list. Its a button! Its full of text!
// Click it, and it'll make your character do a thing to someone (else)!
// It contains:
//   - The path of the interaction
//   - The displayed name of the interaction
//   - Whether or not its lewd
//   - Whether or not its extreme
//   - Whether or not its autoable
//   - Any additional information about the interaction
// Also includes buttons for:
//   - Adding/removing the interaction to your favorites
//   - Starting to record an autoPLAPper with it
// AllInteractions format:
//  [
//    {
//      'InteractionKey' = "/datum/interaction/smooch",
//        'InteractionName' = "Smooch them on the lips.",
//        'InteractionLewd' = false,
//        'InteractionCanAuto' = true,
//        'InteractionExtreme' = true,
//        'InteractionAdditional' = "trust me its very extreme",
//        'InteractionCategories' = ["this", "that", "those"],
//    },
//  ], ...
const InteractionButton = (props, context) => {
  const { act, data } = useBackend(context);
  const Faves = data.Faves || [];
  const AutoPlapObjs = data.AutoPlapObjs || [];
  const WeConsent = data.WeConsent || false;

  const IOBJ = props.IOBJ || {};
  const IKey = IOBJ.InteractionKey || "/datum/interaction/smooch";
  const IName = IOBJ.InteractionName || "Bend them over a table and runtime them.";
  const ILewd = IOBJ.InteractionLewd || false;
  const ICanAuto = IOBJ.InteractionCanAuto || false;
  const IExtreme = IOBJ.InteractionExtreme || false;
  const IAdditional = IOBJ.InteractionAdditional || "Oh no!";

  const IsFave = Faves.includes(IKey);

  const BGColor = IExtreme ? 'red' : ILewd ? 'pink' : 'default';

  return (
    <Box width="100%">
      <Flex direction="row">
        <Flex.Item grow={1}>
          <Button
            width="100%"
            disabled={!WeConsent}
            textAlign="left"
            tooltip={IAdditional}
            backgroundColor={BGColor}
            onClick={() =>
              act('interact', {
                interaction: IKey,
              })}>
            {IName}
          </Button>
        </Flex.Item>
        {!!ICanAuto && (
          <Flex.Item shrink={1}>
            <AutoPlapRecordButton Iobj={IOBJ} />
          </Flex.Item>
        )}
        <Flex.Item shrink={1}>
          <FavoriteButton Iobj={IOBJ} IsFave={IsFave} />
        </Flex.Item>
      </Flex>
    </Box>
  );
};

// A button that when clicked, will add or remove the interaction from
// your favorites list. It takes in the interaction key, and whether or not
// its already in your favorites list, and spits out the appropriate button
// with the appropriate tooltip.
const FavoriteButton = (props, context) => {
  const { act, data } = useBackend(context);
  const IOBJ = props.Iobj || {};
  const IsFave = props.IsFave || false;

  const ButtText = IsFave ? "Remove from Favorites" : "Add to Favorites";
  const ButtColor = IsFave ? "green" : "default";
  const ButtIcon = IsFave ? "heart" : "heart-o";

  return (
    <Button
      color={ButtColor}
      tooltip={ButtText}
      width="fit-content"
      onClick={() =>
        act('Favorite', {
          interaction: IOBJ.InteractionKey,
        })} >
      <Icon name={ButtIcon} color={ButtColor} />
    </Button>
  );
};

// A button that when clicked, will start recording an autoPLAPper with
// the given interaction, or cancel recording if its already recording.
// It takes in the interaction key, and spits out the appropriate button
// with the appropriate tooltip.
const AutoPlapRecordButton = (props, context) => {
  const { act, data } = useBackend(context);
  const IOBJ = props.Iobj || {};
  // if something is being recorded, anything, this will be the key of it
  const RecordingObjs = data.Recording || {};
  const IsThisRecording = RecordingObjs.includes(IOBJ.InteractionKey);

  if (RecordingObjs.length && !IsThisRecording) {
    return (
      <Button
        icon="ban"
        color="red"
        disabled={true}
        tooltip="Something else is recording!!!" />
    );
  }
  if (IsThisRecording) {
    return (
      <Button
        icon="times"
        color="red"
        tooltip="Cancel Recording"
        onClick={() =>
          act('StopRecording', {
            interaction: IOBJ.InteractionKey,
          })} />
    );
  }
  return (
    <Button
      color="green"
      tooltip="Record AutoPLAP"
      onClick={() =>
        act('StartRecording', {
          interaction: IOBJ.InteractionKey,
        })} >
      <Icon name="circle" color="red" />
    </Button>
  );
};

// A helper function for QuirkList to get an array of quirk objects
// that are in a given category. It takes a category name, and an array
// of quirk objects, and returns an array of quirk objects.
const GetInteractionsInCategory = (props, context) => {
  const { data } = useBackend(context);
  const AllInteractions = data.AllInteractions || [];
  const AllCategories = data.AllCategories || [];
  const CategoryName = props || AllCategories[0] || '';
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', FavePlaps);

  /// If the category is favorites, we need to filter the list of all quirks
  /// to only include the ones that are in the user's favorites list.
  if (SelectedCategory === FavePlaps) {
    if(data.Faves.length === 0) {
      return [];
    }
    return AllInteractions.filter(Interaction => {
      return data.Faves.includes(Interaction.InteractionKey);
    }) || [];
  }

  if (SearchTerm.length > 0) {
    return AllInteractions.filter(Interactions => {
      return Interactions.InteractionName.toLowerCase().includes(SearchTerm.toLowerCase()) || [];
    });
  }

  if (!CategoryName || CategoryName === AllCategories[0]) {
    return AllInteractions; // return em all
  }
  /// Otherwise, we need to filter the list of all quirks to only include
  /// the ones that are in the selected category.
  return AllInteractions.filter(Interaction => {
    return Interaction.InteractionCategories.includes(CategoryName);
  }) || [];
};


// Gormless Kong
// A helper function to make a page bar for the quirk list, so we dont have to
// render 200 darn buttons at once. It pulls the current page from the
// local state, and the number of pages from the length of the quirks list.
// Nah we dont have to truncate the page list, we can just make it a
// big fat box
const InteractionPage = (props, context) => {
  const { act, data } = useBackend(context);
  const LewdMode = data.LewdMode || false;
  const AllInteractions = data.AllInteractions || [];
  const AllCategories = data.AllCategories || [];
  const [
    CurrentPage,
    setCurrentPage,
  ] = useLocalState(context, 'CurrentPage', 1);

  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');

  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', FavePlaps);

  const Cat2Use = SearchTerm ? AllInteractions[0] : SelectedCategory;
  const FilteredAllInteractions = GetInteractionsInCategory(Cat2Use, context);
  const ShowPageButtons = FilteredAllInteractions.length > PlapsPerPage;

  const TotalPageNum = Math.ceil(FilteredAllInteractions.length / PlapsPerPage);

  const PrevButton = (ShowPageButtons &&
    <Button
      fluid
      inline
      px="0.5em"
      py="0.25em"
      disabled={CurrentPage === 1}
      onClick={() =>
      { act('sound', { 'DoSound': 'TabClick' });
        setCurrentPage(CurrentPage - 1); }}>
      <Icon name="chevron-left" />
    </Button>
  );
  const NextButton = (ShowPageButtons &&
    <Button
      inline
      px="0.5em"
      py="0.25em"
      disabled={CurrentPage >= TotalPageNum}
      onClick={() =>
      { act('sound', { 'DoSound': 'TabClick' });
        setCurrentPage(CurrentPage + 1); }}>
      <Icon name="chevron-right" />
    </Button>
  );
  const LewdText = LewdMode ? "Hide Lewd Stuff" : "Show Lewd Stuff";
  const LewdButton = (
    <Button
      inline
      onClick={() =>
      { act('ToggleLewdMode'); }}>
      {LewdText}
    </Button>
  );

  return (
    <Flex>
      <Flex.Item grow={1} >
        <Box inline px="1em" py={1}>
          {LewdButton}
          <Box inline px="1em" />
        </Box>
      </Flex.Item>
      <Flex.Item>
        {ShowPageButtons && (
          <Box inline px="1em" py={1}>
            Page {CurrentPage} / {TotalPageNum}
          </Box>
        )}
      </Flex.Item>
      <Flex.Item shrink={0}>
        {PrevButton}
        {NextButton}
        <Box inline px="1em" />
      </Flex.Item>
    </Flex>
  );
};




















