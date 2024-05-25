/* eslint-disable max-len */
import { filter, map, sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { clamp } from 'common/math';
import { createSearch } from 'common/string';
import { useBackend, useLocalState } from '../backend';
import { Button, Flex, Fragment, NumberInput, Icon, Input, Section, Table, NoticeBox, Stack, ProgressBar, Box } from '../components';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';
import { round, toFixed } from '../../common/math';


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
    SeeLewd,
  } = data;
  const WindoHight = SeeLewd ? 700 : 400;
  // const TopBasis = SeeLewd ? "50%" : "0%";
  // const BottomBasis = SeeLewd ? "50%" : "100%";

  return (
    <Window
      width={600}
      height={WindoHight} // i know what I did
      resizable>
      <Window.Content>
        <Stack fill vertical>
          {!!SeeLewd && (
            <Stack.Item shrink={1} basis="40%">
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

  return (
    <Box height="100%">
      <Stack fill>
        <Stack.Item basis="50%"> {/* Left Panel */}
          <Box height="100%">
            <Stack fill vertical alignItems="flex-end" justifyContent="flex-end">
              <Stack.Item grow={1}>
                <Section height="100%">
                  <Nads /> {/* Your and their NADs */}
                </Section>
              </Stack.Item>
              <Stack.Item shrink={1}>
                <Lust />
              </Stack.Item>
            </Stack>
          </Box>
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

  const MyNads = data.MyGenitals || [];
  const TheirNads = data.TheirGenitals || [];
  const MyName = data.MyName || "You";
  const TheirName = data.TheirName || "Them";
  const MyOrientations = data.MyOrientations || [];
  const TheirOrientations = data.TheirOrientations || [];
  const ItsJustMe = data.ItsJustMe || false;

  // const TheyGotNads = TheirNads && TheirNads.length > 0;
  // const TheyGotOrientations = TheirOrientations && TheirOrientations.length > 0;
  const ShowTheirSide = !ItsJustMe;
  if (TheirNads.length === 0) {
    TheirNads.push({
      "BitKind": "Nothin!",
      "BitName": "Nothing at all!",
      "BitSize": "Small",
      "BitColor": "#FFFFFF",
      "BitAroused": false,
      "BitExtra": "Minty",
      "BitEmoji": ":)",
    });
  }
  if (TheirOrientations.length === 0) {
    TheirOrientations.push({
      "OriName": "Non-aligned",
      "OriDesc": "I'm cool beans",
      "OriEmoji": ":)",
    });
  }


  return (
    <Section
      height="100%"
      minHeight="100%"
      overflowY="auto">
      <Flex direction="row" wrap="wrap" height="100%">
        {/* the name row */}
        <Flex.Item basis="50%" textAlign="center" bold>
          {MyName}
          <hr />
        </Flex.Item>
        <Flex.Item basis="50%" textAlign="center" bold>
          {ShowTheirSide ? TheirName : "Yourself"}
          {ShowTheirSide ? <hr /> : <Box />}
        </Flex.Item>
        {ShowTheirSide && (
          <>
            <Flex.Item basis="50%" textAlign="center" />
            <Flex.Item basis="50%" textAlign="center">
              <Consent />
            </Flex.Item>
          </>
        )}
        {/* the naughty bits row */}
        <Flex.Item basis="50%" textAlign="center" bold>
          {MyNads.map(Nad => (
            <GuntButton
              genital={Nad}
              JustMe={ItsJustMe}
              context={context}
              key={Nad.BitName} />
          ))}
        </Flex.Item>
        <Flex.Item basis="50%" textAlign="center">
          {ShowTheirSide && (
            TheirNads.map(Nad => (
              <GuntButton
                genital={Nad}
                context={context}
                key={Nad.BitName} />
            ))
          )}
        </Flex.Item>
        {/* the orientation row */}
        <Flex.Item basis="50%" textAlign="center">
          {MyOrientations.map(Ori => (
            <OrientationButton
              orientation={Ori}
              JustMe={ItsJustMe}
              context={context}
              key={Ori.OriName} />
          ))}
        </Flex.Item>
        <Flex.Item basis="50%" textAlign="center">
          {ShowTheirSide && (
            TheirOrientations.map(Ori => (
              <OrientationButton orientation={Ori} context={context} key={Ori.OriName} />
            ))
          )}
        </Flex.Item>
      </Flex>
    </Section>

  );
};


// / GuntButton! Takes in a genital object thing, and formats it into a button
// / that shows a tooltip about the genital
const GuntButton = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    BitKind,
    BitName,
    BitSize,
    BitColor,
    BitAroused,
    BitExtra,
    BitEmoji,
  } = props.genital || {
    BitKind: "muffin",
    BitName: "Tuffy",
    BitSize: "Small",
    BitColor: "#FFFFFF",
    BitAroused: false,
    BitExtra: "Minty",
    BitEmoji: ":)",
  };
  // const WinWidth = window.innerWidth;
  // const WinHeight = window.innerHeight;
  // const FontWindowSize = WinWidth * 0.001;
  const FontWindowSize = "3vw";
  const FSize = props.JustMe ? "2.5em" : "2em";

  const ArousedText = BitAroused ? "Happens to be aroused" : "Happens to not be Aroused";
  const ToolTipText
    = BitName + " "
    + BitSize + " "
    + BitExtra;
    // ArousedText + "\n" +

  return (
    <Button
      tooltip={ToolTipText}
      color="transparent"
      onClick={() => act('interact', {
        interaction: "poke",
        ExtraStuff: {
          PokeThing: BitName,
        },
      })} >
      <Box
        inline
        textColor={BitColor}
        fontSize={FontWindowSize}
        textAlign="center">
        {BitEmoji}
      </Box>
    </Button>
  );
};

// / OrientationButton! Takes in an orientation object thing, and formats it into a button
// / that shows a tooltip about the orientation
const OrientationButton = (props) => {
  const {
    OriName,
    OriDesc,
    OriEmoji,
  } = props.orientation || {
    OriName: "Non-aligned",
    OriDesc: "I'm cool beans",
    OriEmoji: ":(",
  };
  const FSize = props.JustMe ? "2.5em" : "2em";
  // const WinWidth = window.innerWidth;
  // const WinHeight = window.innerHeight;
  const FontWindowSize = "3vw";

  return (
    <Button
      color="transparent"
      tooltip={OriDesc} >
      <Box
        inline
        fontSize={FontWindowSize}
        color="green"
        textAlign="center">
        {OriEmoji}
      </Box>
    </Button>
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

  return (
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
  const MyLust = data.MyLust || 0;
  const MyMaxLust = data.MyMaxLust || 100;
  const TheirLust = data.TheirLust || 0;
  const TheirMaxLust = data.TheirMaxLust || 100;
  const ItsJustMe = data.ItsJustMe || false;
  const MTTC = data.MTTC; // Mean Time To Cum
  const CanCum = data.CanCum || false;
  const MyName = data.MyName || "You";
  const TheirName = data.TheirName || "Them";

  // dark lusty purple
  const LustBGColor = "purple";
  // bright lusty pink
  const LustFGColor = "pink";

  const CumButtonText = "!! C U M !!";
  const AutocumText = CanCum ? "Autocum: ON" : "Autocum: OFF";
  // let AutocumArray = [];
  // /// run through the bitfields in AutocumFlags and assemble the appropriate text
  // if(AutocumFlags) {
  //   if(AutocumFlags & 1) {
  //     AutocumArray.push("they cum");
  //   }
  //   if(AutocumFlags & 2) {
  //     AutocumArray.push("you're full of lust");
  //   }
  //   if(AutocumFlags & 4) {
  //     AutocumArray.push("they're full of lust");
  //   }
  // }
  // /// assembles them into a string, like:
  // /// "You'll cum when they cum, you're full of lust, and they're full of lust"
  // if(AutocumArray.length > 0) {
  //   for(let i = 0; i < AutocumArray.length; i++) {
  //     if(i === 0) {
  //       AutocumText += AutocumArray[i];
  //     } else if(i === AutocumArray.length - 1) {
  //       AutocumText += ", and " + AutocumArray[i];
  //     } else {
  //       AutocumText += ", " + AutocumArray[i];
  //     }
  //   }
  // } else {
  //   AutocumText += "you feel like it!";
  // }

  const AutocumColor = CanCum ? "green" : "default";

  const CelWidth = ItsJustMe ? "100%" : "50%";

  const TheirFixedLust = toFixed(TheirLust, 1);
  const TheirFixedMaxLust = toFixed(TheirMaxLust, 1);
  const MyFixedLust = toFixed(MyLust, 1);
  const MyFixedMaxLust = toFixed(MyMaxLust, 1);

  return (
    <Section>
      <Flex direction="row" wrap="wrap">
        {/* the name row */}
        <Flex.Item basis={CelWidth} textAlign="center">
          {MyName}
        </Flex.Item>
        {!ItsJustMe && (
          <Flex.Item basis={CelWidth} textAlign="center">
            {TheirName} {/* Nobody's here but you and your hand~ */}
          </Flex.Item>
        )}
        {/* the lust counter row */}
        <Flex.Item basis={CelWidth} textAlign="center">
          <ProgressBar
            value={MyFixedLust}
            color={LustBGColor}
            minValue={0}
            maxValue={MyFixedMaxLust} >
            <Box inline color={LustFGColor} textAlign="right">
              {MyFixedLust} / {MyFixedMaxLust}
            </Box>
          </ProgressBar>
        </Flex.Item>
        {!ItsJustMe && (
          <Flex.Item basis={CelWidth} textAlign="center">
            <ProgressBar
              fromRight
              value={TheirFixedLust}
              color={LustBGColor}
              minValue={0}
              maxValue={TheirFixedMaxLust} >
              <Box fluid color={LustFGColor} textAlign="left">
                {TheirFixedLust} / {TheirFixedMaxLust}
              </Box>
            </ProgressBar>
          </Flex.Item>
        )}
        {/* the cum button row */}
        <Flex.Item basis="100%" wrap="wrap">
          <Flex direction="column">
            <Flex.Item>
              <Button
                fluid
                mb={0.3}
                disabled={!CanCum}
                color="pink"
                content={CumButtonText}
                bold={CanCum}
                onClick={() => act('Cum')} />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                mb={0.3}
                color={AutocumColor}
                content={AutocumText}
                bold={CanCum}
                onClick={() => act('ToggleAutoCum')} />
            </Flex.Item>
          </Flex>
        </Flex.Item>
      </Flex>
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

  return (
    <Section
      title="Auto-Interaction"
      height="100%"
      minHeight="100%"
      overflowY="scroll"
      buttons={(
        <Fragment>
          <Button
            icon={"pause"}
            onClick={() => act('StopAllAutoPlappers')} />
          <Button
            icon={"play"}
            onClick={() => act('StartAllAutoPlappers')} />
          <Button
            color={AutoPlapAutoStart ? "green" : "default"}
            icon={AutoPlapAutoStart ? "toggle-on" : "toggle-off"}
            tooltip={"Auto-Start: " + YesOrNo}
            onClick={() => act('ToggleAutoStart')} />
        </Fragment>
      )}>
      <Box>
        {AutoPlapObjs.length ? (
          AutoPlapObjs.map(autoPlap => (
            <Box key={autoPlap.key}>
              <AutoPlapControl AutoPlapObj={autoPlap} />
            </Box>
          ))
        ) : (
          "To add some, click the red dot by an interaction!"
        )}
      </Box>
    </Section>
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
    APPlapper, // The name of the person is doing the PLAPping
    APPartner, // The name of the person being PLAPped
    APInterval, // The interval of the PLAPping, in deciseconds
    APPlapping, // Whether or not the PLAPping is active
    APPlapcount, // How many times the PLAPping has happened
    APRecording, // If this is recording, meaning its still in its setup phase
  } = AutoPlapObj;

  const MinAutoplapInterval = data.MinAutoplapInterval || 15;
  const MaxAutoplapInterval = data.MaxAutoplapInterval || 300;

  const APPlappingIcon = APPlapping ? "pause" : "play";
  const APPlapColor = APPlapping ? "" : "green";
  const APRecordingIcon = APRecording ? "ban" : "circle";
  const APRecordingColor = APRecording ? "red" : "red"; // red and also red

  const MyPartner = APPlapper === APPartner ? "Yourself" : APPartner;

  return (
    <Box
      mb="0.5em"
      p="0.5em"
      fontSize="0.8rem"
      backgroundColor="#2f2f2f">
      <Stack fill vertical>
        <Stack.Item>
          <Flex direction="row">
            <Flex.Item grow={1}>
              <Box
                inline
                bold>
                {APPlapName}
              </Box>
            </Flex.Item>
            {!!APRecording && (
              <Flex.Item shrink={1}>
                <Button
                  icon={APRecordingIcon}
                  color={APRecordingColor}
                  onClick={() => act('StopRecording', {
                    APID: APApid,
                  })} />
              </Flex.Item>
            )}
          </Flex>
        </Stack.Item>
        <Stack.Item>
          <Flex direction="row">
            <Flex.Item grow={1}>
              <NumberInput
                animated
                unit="sec/PLAP"
                width="4.5em"
                minValue={MinAutoplapInterval}
                maxValue={MaxAutoplapInterval}
                value={APInterval}
                step={1}
                stepPixelSize={3}
                format={value => {
                  return toFixed((value * 0.1), 1);
                }}
                onDrag={(e, value) => act('SetAutoPlapperInterval', {
                  APID: APApid,
                  Interval: value, // 30 seconds
                })} />
            </Flex.Item>
            <Flex.Item shrink={1}>
              <Button
                icon={APPlappingIcon}
                color={APPlapColor}
                onClick={() => act('ToggleAutoPlapper', {
                  APID: APApid,
                })} />
              <Button
                icon="trash"
                onClick={() => act('DeleteAutoPlapper', {
                  APID: APApid,
                })} />
            </Flex.Item>
          </Flex>
        </Stack.Item>
        <Stack.Item>
          <Box textColor="label">
            {APPlapper} <Icon name="arrow-right" /> {MyPartner},  {APPlapcount} times!
          </Box>
        </Stack.Item>
      </Stack>
    </Box>
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
    MyName,
    SeeLewd,
  } = data;
  const Tilda = SeeLewd ? "~" : "!";

  return (
    <Box
      height="100%"
      width="100%">
      <Stack fill vertical>
        <Stack.Item>
          <Section
            width="100%"
            title={"Welcome, " + MyName + Tilda}
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
                <InteractionJizz />
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
// of an interaction. or dragon pussy. I've promised it across like 4 PRs now,
// Ive gotta deliver at some point.
const InteractionSearchBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    DP,
    SearchTerm,
  } = data;

  const FillerText = DP ? "Dragon Pussy" : "Find-A-Plap 0.1b (tm)";

  let SearchText = SearchTerm || "";

  return (
    <Box inline width="fit-content">
      <Input
        width="15em"
        placeholder={FillerText}
        value={SearchText}
        onInput={(e, value) =>
          act('UpdateSearch', {
            SearchTerm: value,
          })} />
    </Box>
  );
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
  const SelectedCategory = data.CurrCategory || "Oh no";

  return (
    <Button
      key={CatName}
      fluid
      px="0.5em"
      py="0.25em"
      selected={SelectedCategory.toLowerCase() === CatName.toLowerCase()}
      onClick={() =>
        act('UpdateCategory', {
          category: CatName,
        })}>
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
  const DP = data.DP || false;
  const AllInteractions = data.AllInteractions || [];


  const WhyIsItEmpty = DP ? "You've been visited by the gunderful dragon pussy! \
    This only happens once every 4000 years! Yell DRAGON PUSSY in OOC in 30 seconds \
    or you'll never have dragon pussy again!" : "No interactions in this category!";

  return (
    <Box>
      {AllInteractions.length === 0 && (
        <NoticeBox active>
          {WhyIsItEmpty}
        </NoticeBox>
      )}

      {AllInteractions.map(Plap => (
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

  const CantClick = ILewd && !WeConsent;

  const IsFave = Faves.includes(IKey);

  const BGColor = IExtreme ? 'red' : ILewd ? 'pink' : 'default';

  return (
    <Box width="100%">
      <Flex direction="row">
        <Flex.Item grow={1}>
          <Button
            width="100%"
            disabled={CantClick}
            textAlign="left"
            tooltip={IAdditional}
            tooltipPosition="top"
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
  const ButtColor = IsFave ? "pink" : "default";
  const ButtIcon = IsFave ? "heart" : "heart-o";

  return (
    <Button
      icon={ButtIcon}
      iconColor={ButtColor}
      tooltipPosition="top"
      tooltip={ButtText}
      width="fit-content"
      onClick={() =>
        act('Favorite', {
          interaction: IOBJ.InteractionKey,
        })} />
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
  // / Searches through RecordingObjs and checks if APPlapKey matches
  // / the interaction key of the interaction we're looking at
  const IsThisRecording = RecordingObjs.some(RecordingObj => {
    return RecordingObj.APPlapKey === IOBJ.InteractionKey;
  });

  if (IsThisRecording) {
    return (
      <Button
        textAlign="center"
        icon="times"
        color="red"
        tooltip="Cancel Recording"
        tooltipPosition="top"
        onClick={() =>
          act('StopRecording', {
            APID: IsThisRecording.APApid,
          })} />
    );
  }
  if (RecordingObjs.length) {
    return (
      <Button
        icon="ban"
        color="red"
        disabled
        tooltip="Something else is recording!!!" />
    );
  }
  return (
    <Button
      icon="circle"
      iconColor="red"
      textAlign="center"
      tooltip="Record AutoPLAP"
      tooltipPosition="top"
      onClick={() =>
        act('StartRecording', {
          interaction: IOBJ.InteractionKey,
        })} />
  );
};


// Gormless Kong
// A helper function to make a page bar for the interaction list, so we dont have to
// render 200 darn buttons at once. It pulls the current page from the
// local state, and the number of pages from the length of the interactions list.
// Nah we dont have to truncate the page list, we can just make it a
// big fat box
const InteractionPage = (props, context) => {
  const { act, data } = useBackend(context);
  const SeeLewd = data.SeeLewd || false;
  const SeeLewdMessages = data.SeeLewdMessages || false;
  const HearLewdSounds = data.HearLewdSounds || false;
  const CanPgUP = data.CanPgUP || false;
  const CanPgDN = data.CanPgDN || false;
  const CurrPage = data.CurrPage || 1;
  const MaxPage = data.MaxPage || 1;

  const ShowPageButtons = MaxPage > 1;

  const LewdText = SeeLewd ? "Hide Lewd Stuff" : "Show Lewd Stuff";
  const LewdButton = (
    <Button
      inline
      onClick={() =>
      { act('ToggleSeeLewd'); }}>
      {LewdText}
    </Button>
  );
  // const SeeMessages =(
  //   <Button
  //     inline
  //     icon="comment"
  //     selected={SeeLewdMessages}
  //     tooltip={SeeLewdMessages ? "Hide Lewd Messages" : "Show Lewd Messages"}
  //     onClick={() =>
  //     { act('ToggleSeeLewdMessages'); }} />
  // );
  const HearSounds =(
    <Button
      inline
      icon="volume-up"
      selected={HearLewdSounds}
      tooltip={HearLewdSounds ? "Mute Lewd Sounds" : "Hear Lewd Sounds"}
      onClick={() =>
      { act('ToggleHearLewdSounds'); }} />
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
        {/* {SeeMessages} They already consented! */}
        {HearSounds}
        <Box inline px="1em" />
      </Flex.Item>
      <Flex.Item>
        {ShowPageButtons && (
          <Box inline px="1em" py={1}>
            Page {CurrPage} / {MaxPage}
          </Box>
        )}
      </Flex.Item>
      <Flex.Item shrink={0}>
        {!!ShowPageButtons && (
          <>
            <Button
              fluid
              inline
              px="0.5em"
              py="0.25em"
              disabled={CurrPage === 1}
              onClick={() => {
                act('PgDOWN');
              }}>
              <Icon name="chevron-left" />
            </Button>
            <Button
              inline
              px="0.5em"
              py="0.25em"
              disabled={CurrPage >= MaxPage}
              onClick={() => {
                act('PgUP');
              }}>
              <Icon name="chevron-right" />
            </Button>
          </>
        )}
        <Box inline px="1em" />
      </Flex.Item>
    </Flex>
  );
};
