/* eslint-disable */
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Section, Stack, Fragment, Flex, Icon, Input, NoticeBox, Table } from '../components';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';
const YourQuirks = 'Your Quirks';
const QuirksPerPage = 10;

// The primary window, holds two sections:
// the left section is the list of categories in AllQuirks,
// the right section is the list of quirks in the selected category,
// populated the list of quirks in AllQuirks's selected category.
// Will also include a search bar at the top of the window.
// But we're geting ahead of ourselves! Let's start with the top-level
// Window skeleton!
// / AllQuirks format:
///  [
// /    {
// /      'Qkey' : string,
// /      'Qname' : string,
// /      'Qdesc' : string,
// /      'Qpath' : string,
// /      'Qvalue' : number,
// /      'Qdesc' : string,
// /      'Qmechanics' : string,
// /      'Qconflicts' : array,
// /      'Qcategory' : string,
// /      'Qhumanonly' : string
// /    },
// /  ], ...
// and here's the format of UserQuirks:
// [ 'quirk_key_1', 'quirk_key_2', ... ]
// Yeah that ones a lot smaller~
export const QuirkMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserName,
  } = data;
  const AllQuirks = data.AllQuirks || [];
  const AllCategories = data.AllCategories || [];
  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', YourQuirks);
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const Cat2Use = SearchTerm ? AllQuirks[0] : SelectedCategory;
  const FilteredAllQuirks = GetQuirksInCategory(Cat2Use, context);
  const WhyIsItEmpty = SearchTerm
    ? "No quirks found!"
    : SelectedCategory === AllQuirks[0]
      ? "Congratulations! You've been selected to open an issue on Github!"
      : "No quirks in this category!";

  return (
    <Window
      theme="ntos"
      width={640}
      height={768}
      resizable>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Section
              width="100%"
              title={"Welcome, " + UserName + "!"}
              buttons={(
                <QuirkSearchBar />
              )}>
              <QuirkHeaderThings />
            </Section>
          </Stack.Item>
          <Stack.Item grow={1} basis={1}>
            <Section
              fill
              width="100%"
              scrollable>
              <Flex direction="row">
                <Flex.Item shrink={0}>
                  <QuirkCategoryList />
                </Flex.Item>
                <Flex.Item grow={1} basis={0}>
                  <QuirkJizz QuirksInCat={FilteredAllQuirks} />
                </Flex.Item>
              </Flex>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <QuirkPageBar />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

// The header of the window. Its a box! It has a bunch of text!
// It also has a readout of how many quirk points you've spent,
// and how many you have left.
const QuirkHeaderThings = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserCkey,
    UserQuirkPoints,
    UserQuirkGoods,
    MaxQuirkPoints,
    MaxGoodQuirks,
  } = data;

  const QuirkPointReadout = (
    <Box
      inline
      color={UserQuirkPoints >= MaxQuirkPoints ? 'bad' : 'good'}>
      {UserQuirkPoints}
    </Box>
  );
  const QuirkGoodReadout = (
    <Box
      inline
      color={UserQuirkGoods >= MaxGoodQuirks ? 'bad' : 'good'}>
      {UserQuirkGoods}
    </Box>
  );

  return (
    <Fragment>
      <Flex direction="row">
        <Flex.Item basis="25%">
          <Button
            fluid
            bold
            fontSize="18px"
            style={{
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
            }}
            height="100%"
            color="bad"
            textAlign="center"
            content="Reset Quirks"
            onClick={() => act('ClearQuirks', {
              'UserCkey': UserCkey,
              'DoSound': "ResetQuirks",
            })} />
        </Flex.Item>
        <Flex.Item basis="50%">
          <Box
            mx="0.5rem"
            width="100%"
            textAlign="center"
            fontSize="14px"
            color="label">
            <Flex direction="row">
              <Flex.Item grow={1}>
                <Box />
              </Flex.Item>
              <Flex.Item>
                <Stack fill>
                  <Stack.Item>
                    <Box
                      textAlign="right"
                      fontSize="18px"
                      color="label">
                      <Stack fill vertical pr="0.25rem">
                        <Stack.Item>
                          Quirk Points:
                        </Stack.Item>
                        <Stack.Item>
                          Good Quirks:
                        </Stack.Item>
                      </Stack>
                    </Box>
                  </Stack.Item>
                  <Stack.Item>
                    <Box
                      textAlign="left"
                      fontSize="18px"
                      color="label">
                      <Stack fill pl="0.25rem">
                        <Stack.Item textAlign="right">
                          <Stack fill vertical>
                            <Stack.Item>
                              {QuirkPointReadout} /
                            </Stack.Item>
                            <Stack.Item>
                              {QuirkGoodReadout} /
                            </Stack.Item>
                          </Stack>
                        </Stack.Item>
                        <Stack.Item>
                          <Stack fill vertical>
                            <Stack.Item>
                              {MaxQuirkPoints}
                            </Stack.Item>
                            <Stack.Item>
                              {MaxGoodQuirks}
                            </Stack.Item>
                          </Stack>
                        </Stack.Item>
                      </Stack>
                    </Box>
                  </Stack.Item>
                </Stack>
              </Flex.Item>
              <Flex.Item grow={1}>
                <Box />
              </Flex.Item>
            </Flex>
          </Box>
        </Flex.Item>
        <Flex.Item basis="25%">
          <Button
            fluid
            style={{
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
            }}
            bold
            fontSize="18px"
            height="100%"
            textAlign="center"
            content="Save Quirks"
            onClick={() => act('SaveQuirks', {
              'UserCkey': UserCkey,
              'DoSound': "SaveQuirks",
            })} />
        </Flex.Item>
      </Flex>
      <hr />
    </Fragment>
  );
};


// The search bar at the top of the window.
// Its a search bar! You can look up anything, so long as its the name
// of a quirk. or dragon pussy. I've promised it across like 3 PRs now,
// Ive gotta deliver at some point.
const QuirkSearchBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AllQuirks,
    DP,
  } = data;
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const FillerText = DP ? "Dragon Pussy" : "Find-A-Quirk 0.1b (tm)";

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
  ] = useLocalState(context, 'SelectedCategory', YourQuirks);
  const [
    CurrentPage,
    setCurrentPage,
  ] = useLocalState(context, 'CurrentPage', 1);

  if (SearchTerm.length > 0) {
    setCurrentPage(1);
    setSelectedCategory(AllCategories[0]);
  }
  setSearchTerm(props);
  act('Sound', { 'DoSound': 'SearchType' });
};

// The big holder of the categories! Its a long column of tabs that
// you can click on to select a category. The categories are defined
// in AllQuirks, and the selected category is stored in the local state.
// We'll add on one additional tab at the end, not clickable, that
// will be the tally for all the quirk points you've spent and have left!
const QuirkCategoryList = (props, context) => {
  const { act, data } = useBackend(context);
  const AllCategories = data.AllCategories || [];
  const Firstie = AllCategories[0] || 'Oh no';
  const AllcatsMinusTheFirst = AllCategories.slice(1);
  const AllerCats = [Firstie, YourQuirks].concat(AllcatsMinusTheFirst); // surgery

  return (
    <Box
      p="0.5rem"
      mr="0.5rem"
      width="fit-content"
      backgroundColor="#2f2f2f">
      {AllerCats.map(category => (
        <QuirkTab CatName={category} key={category} />
      ))}
    </Box>
  );
}; // not that big of a proc actually

// / One of the tabs in the category list. Its a tab! It has a name!
// / It also counts up the point value of all those quirks.
// / That value can be negative btw, if you've taken more negative quirks
// / than positive ones.
const QuirkTab = (props, context) => {
  const { act, data } = useBackend(context);
  const AllQuirks = data.AllQuirks || [];
  const AllCategories = data.AllCategories || [];
  const UserQuirkKeys = data.UserQuirkKeys || [];
  const CatName = props.CatName || "Oh no";


  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', YourQuirks);
  const [
    CurrentPage,
    setCurrentPage,
  ] = useLocalState(context, 'CurrentPage', 1);
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');

  const UserQuirkObjs = QKeyArray2ObjArray(UserQuirkKeys, context) || [];
  const UserQuirksInThisCat = UserQuirkObjs.filter(Quirk => Quirk.Qcategory === CatName) || [];
  const TotalQuirkValueInThisCat = CatName === YourQuirks
    ? UserQuirkObjs.reduce((total, Quirk) => total + Quirk.Qvalue, 0)
    : CatName === AllCategories[0]
      ? "(" + AllQuirks.length + ")"
      : UserQuirksInThisCat.reduce((total, Quirk) => total + Quirk.Qvalue, 0);

  const PlusOrMinus = PorM(TotalQuirkValueInThisCat) || '';
  const Colourr = CatName === AllCategories[0] ||TotalQuirkValueInThisCat === 0
    ? 'label'
    : TotalQuirkValueInThisCat > 0
      ? 'good'
      : 'bad';

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
        act('Sound', {
          'DoSound': 'TabClick',
        }); }}>
      <Flex direction="row">
        <Flex.Item grow={1}>
          <Box
            inline
            textAlign={'left'}>
            {CatName}
          </Box>
        </Flex.Item>
        <Flex.Item>
          <Box
            pl="0.5rem"
            inline
            color={Colourr}
            textAlign={'right'}>
            {PlusOrMinus}{TotalQuirkValueInThisCat}
          </Box>
        </Flex.Item>
      </Flex>
    </Button>
  );
};

// The big holder of the quirks! Its a long column of big cool buttons
// that you can click on to select a quirk. The quirks are defined
// in AllQuirks, and any selected quirks are defined in UserQuirks.
// the current category is stored in the local state.
// the category defines what quirks to show. If the category is AllQuirks[0],
// it will show all the quirks in AllQuirks.
const QuirkJizz = (props, context) => {
  const { act, data } = useBackend(context);
  const AllQuirks = data.AllQuirks || [];
  const AllCategories = data.AllCategories || [];
  // format:
  // [
  //   {
  //     'Limb' : string,
  //     'Manufacturer' : string,
  //   },
  //   ...  ]
  const UserProstheticObjs = data.UserProstheticObjs || [];

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
  ] = useLocalState(context, 'SelectedCategory', YourQuirks);

  const FilteredAllQuirks = GetQuirksInCategory(SelectedCategory, context);

  const Paginate = SearchTerm !== '' || SelectedCategory === AllCategories[0]
    ? true
    : false;
  const ShowRange = Paginate ? [CurrentPage * QuirksPerPage - QuirksPerPage, CurrentPage * QuirksPerPage] : [0, FilteredAllQuirks.length];
  const ShowQuirks = FilteredAllQuirks.slice(ShowRange[0], ShowRange[1]);

  const WhyIsItEmpty = SearchTerm
    ? "No quirks found!"
    : SelectedCategory === AllCategories[0]
      ? "Congratulations! You've been selected to open an issue on Github! Use the keyword 'Dragon Pussy' for 15% off your tech support!"
      : "No quirks in this category!";

  return (
    <Box>
      {ShowQuirks.length === 0 && UserProstheticObjs.length === 0 && (
        <NoticeBox active>
          {WhyIsItEmpty}
        </NoticeBox>
      )}
      {SelectedCategory === YourQuirks && UserProstheticObjs.map(Prosthetic => (
        <Box
          key={Prosthetic}
          mr="0.5em"
          mb="0.5em">
            <LimbButton LOBJ={Prosthetic} />
        </Box>
      ))}
      {ShowQuirks.map(Quirk => (
        <Box
          key={Quirk.Qkey}
          mr="0.5em"
          mb="0.5em">
          <QuirkButton QOBJ={Quirk} />
        </Box>
      ))}
    </Box>
  );
};

// / One of the buttons in the quirk list. Its a button! Its full of text!
// / Click it, and it'll tell BYOND to give the player that quirk.
// / It contains: the name of the quirk, the point value of the quirk,
// / a flavor text description of the quirk, a mechanics description of the
// / quirk, and a list of quirks that conflict with this one.
// / AllQuirks format:
// /  [
// /    {
// /      'Qkey' : string,
// /      'Qname' : string,
// /      'Qdesc' : string,
// /      'Qpath' : string,
// /      'Qvalue' : number,
// /      'Qdesc' : string,
// /      'Qmechanics' : string,
// /      'Qconflicts' : array,
// /      'Qcategory' : string,
// /      'Qhumanonly' : string
// /    },
// /  ], ...
const QuirkButton = (props, context) => {
  const { act, data } = useBackend(context);
  const UserQuirkKeys = data.UserQuirkKeys || [];
  /// Who lives in a javascript under the sea?
  //const UserQuirksConflictingKeys = data.UserQuirksConflictingKeys || [];
  const UserCkey = data.UserCkey || 'Guest';
  const UserName = data.UserName || 'Buddy';

  const QuirkObj = props.QOBJ || {
    'Qkey': 'Oh. Ohhhhh no.',
    'Qname': 'Oh no.',
    'Qdesc': 'Wonderful, QuirkButton thing broke.',
    'Qpath': 'help',
    'Qvalue': 10180085,
    'Qmechanics': 'Makes Dan go augh. Report for expensive dragon pussy.',
    'Qconflicts': [],
    'Qcategory': 'All Quirks',
    'Qhumanonly' : '👨',
  };

  const QuirkKey = QuirkObj.Qkey || "!";
  const QuirkName = QuirkObj.Qname || "Quirk";
  const QuirkValue = QuirkObj.Qvalue || 0;
  const PlusOrMinus = PorM(QuirkValue) || '';
  const QuirkDesc = QuirkObj.Qdesc || "This is a quirk! Not much is known about it!";
  const QuirkMechanics = QuirkObj.Qmechanics || "Supposedly does something!";
  const QuirkConflicts = QuirkObj.Qconflicts || [];
  const QuirkHumanOnly = QuirkObj.Qhumanonly || "Hmmm";

  const QuirkConflictsObjs = QKeyArray2ObjArray(QuirkConflicts, context) || [];

  const UserQuirkObjs = QKeyArray2ObjArray(UserQuirkKeys, context) || [];
  /// Now, search through all the user's quirk objects and find any that conflict with this one,
  /// or if this one conflicts with any of them.
  const UserQuirksConflictingObjs = UserQuirkObjs.filter(Quirk => {
    return Quirk.Qconflicts.includes(QuirkKey) || QuirkConflicts.includes(Quirk.Qkey);
  }) || [];
  const ConflictDetected = UserQuirksConflictingObjs.length > 0 ? true : false;

  const UserHasQuirk = UserQuirkKeys.includes(QuirkKey);
  const CanRemoveIt = UserCanRemoveQuirk(QuirkObj, context);
  const CanAffordIt = UserCanAffordQuirk(QuirkObj, context);
  const CanGoodIt = UserCanGoodQuirk(QuirkObj, context);

  const CanRemoveItText = CanRemoveIt ? "" : " (Would put you over your quirk point limit!)";


  // They can click it IF:
  //
  const CanClickIt = (
    !UserHasQuirk
    && CanAffordIt
    && CanGoodIt
    && !ConflictDetected
  ) || (
    UserHasQuirk
      && CanRemoveIt
  );

  const CantAffordText = !CanClickIt && !CanAffordIt ? " (Too Expensive!)" : '';
  const TooManyGoodText = !CanClickIt && !CanGoodIt ? " (Too Many Good Quirks!)" : '';

  const TitleColor =
  UserHasQuirk
    ? CanClickIt
      ? "white"
      : "white"
    : CanClickIt
      ? "#FFFFFF"
      : "#442222";

  const BGColor = UserHasQuirk ? "#448844" : CanClickIt ? "" : "#884444";
  const MiniTextColor = UserHasQuirk ? "white" : CanClickIt ? "white" : "#221111";
  const QuirkCostColor =
  !CanClickIt // refactor it, I know you want to
    ? UserHasQuirk
      ? QuirkValue > 0
        ? "#223322"
        : "#88AAAA"
      : "#442222"
    : QuirkValue == 0
      ? MiniTextColor
      : QuirkValue > 0
        ? "#00FF00"
        : "#FF0000";

  let SoundAct = "Generic";
  if (CanClickIt) {
    if (UserHasQuirk) {
      SoundAct = "RemoveQuirk";
    } else if (!UserHasQuirk) {
      SoundAct = "AddQuirk";
    }
  } else if (ConflictDetected) {
    SoundAct = "Conflicts";
  } else if (!CanAffordIt || !CanRemoveIt) {
    SoundAct = "CantAfford";
  } else if (!CanGoodIt) {
    SoundAct = "TooManyGood";
  }

  return (
    <Button
      px="1rem"
      py="1rem"
      mb="0.5rem"
      mx="0.5rem"
      width="100%"
      selected={UserHasQuirk}
      // disabled={!CanClickIt && !UserHasQuirk} // if you have it, you can unhave it
      textAlign="left"
      backgroundColor={BGColor}
      onClick={() =>
        act('ClickQuirk', {
          'QuirkKey': QuirkKey,
          'UserCkey': UserCkey,
          'UserName': UserName,
          'DoSound': SoundAct,
        })}>
      <NoticeBox
        success={UserHasQuirk}
        active={!CanClickIt}
        width="100%">

        <Box
          style={{
            'border-bottom': '1px solid rgba(255, 255, 255, 0.8)',
          }}
          textAlign="left"
          bold
          fontSize="16px"
          mb="0.5rem"
          color={TitleColor}>
          <Flex direction="row">
            <Flex.Item basis="3em">
              <Box
                color={QuirkCostColor}>
                {PlusOrMinus}{QuirkValue}
              </Box>
            </Flex.Item>
            <Flex.Item grow={1}>
              {QuirkName}
              {CantAffordText}
              {TooManyGoodText}
            </Flex.Item>
          </Flex>
        {}
        </Box>
        {UserHasQuirk && !CanRemoveIt && (
          <Box
            textAlign="center"
            fontSize="14px"
            color="black">
              {CanRemoveItText}
          </Box>
        )}
        {ConflictDetected && UserQuirksConflictingObjs.length > 0 && (
          <ConflictBox UConObjs={UserQuirksConflictingObjs} />
        )}
        <Box
          textAlign="left"
          fontSize="11px"
          style={{
            'border-bottom': '1px solid rgba(255, 255, 255, 0.2)',
          }}
          dangerouslySetInnerHTML={{ __html: QuirkDesc }} />
        <Box
          textAlign="left"
          fontSize="11px"
          color={MiniTextColor}
          dangerouslySetInnerHTML={{ __html: QuirkHumanOnly + QuirkMechanics }} />
        {QuirkConflictsObjs.length > 0 && (
          <Box>
            <ConflictReadout QConflict={QuirkConflictsObjs} TextCol={MiniTextColor} />
          </Box>
        )}
      </NoticeBox>
    </Button>
  );
};

/// Basically the above but for prosthetics
/// WIll be a cool steely gray aesthetic
/// Simpler cus its just an indicator that hey, ur prostheting
const LimbButton = (props, context) => {
  const { act, data } = useBackend(context);
  const LimbObj = props.LOBJ || {};

  const Limb = LimbObj.Limb || "Bingus";
  const Manufacturer = LimbObj.Manufacturer || "Bingus";

  /// dark bluish gray
  const BGColor = "#222244";
  /// steely gray
  const TitleColor = "#DDDDEE";
  /// dark gray
  const MiniTextColor = "#AAAAAA";

  return (
    <Box
      px="1rem"
      py="0.25rem"
      mb="0.5rem"
      mx="0.5rem"
      width="100%"
      textAlign="left"
      backgroundColor={BGColor}
      style={{
        'background-image': 'linear-gradient(#222244, #444466, #444466, #222244)',
      }}>
      <Box
        // style={{
        //   'border-bottom': '1px solid rgba(255, 255, 255, 0.8)',
        // }}
        textAlign="left"
        bold
        fontSize="16px"
        mb="0.5rem"
        color={TitleColor}>
        <Flex direction="row">
          <Flex.Item basis="3em">
            -11
          </Flex.Item>
          <Flex.Item grow={1} color={MiniTextColor}>
            Your {Manufacturer} {Limb}
          </Flex.Item>
        </Flex>
      </Box>
    </Box>
  );
};

// / A helper function for QuirkButton to make a box with a list of
// / quirk objects that conflict with this quirk. It takes an array of
// / quirk keys, and returns a box with a list of quirk names.
const ConflictReadout = (props, context) => {
  const { act, data } = useBackend(context);
  const AllQuirks = data.AllQuirks || [];
  const ConflictObjects = props.QConflict || [];
  const TextCol = props.TextCol || "white";
  if (ConflictObjects.length === 0) {
    return (<Box />);
  }

  return (
    <Flex direction="column">
      <Flex.Item shrink={0}>
        <Box
          textAlign="left"
          fontSize="10px"
          color="#22FAFA">
          <b>Conflicts With:</b>
        </Box>
      </Flex.Item>
      <Flex.Item grow={1}>
        <Box
          textAlign="left"
          fontSize="8px"
          color={TextCol}>
          {ConflictObjects.map(Quirk => (
            <Box
              px="0.25rem"
              py="-0.25rem"
              inline
              key={Quirk.Qkey}>
              {Quirk.Qname}
            </Box>
          ))}
        </Box>
      </Flex.Item>
    </Flex>
  );
};

// / A helper function for QuirkButton to make a box with a list of
// / quirk objects that conflict with this quirk. It takes an array of
// / quirk objects, and returns a box with a list of quirk names.
const ConflictBox = (props) => {
  const UConObjs = props.UConObjs || [];
  if (UConObjs.length === 0) {
    return (<Box />);
  }
  return (
    <Stack.Item>
      <Box color="#880000">
        !!! You have quirks that prevent this one from being taken !!!<br />
        <b>Conflicts With:</b><br />
        {UConObjs.map(conflict => (
          <Button
            key={conflict.Qkey}
            fluid
            backgroundColor="bad"
            textAlign="left"
            tooltip={conflict.Qname + " is incompatible with this one!"}
            tooltipPosition="left">
            <Icon
              name="exclamation-triangle"
              color="bad" />
            {conflict.Qname}
          </Button>
        ))}
      </Box>
    </Stack.Item>
  );
};

// / A helper function for QuirkButton to put a +, -, or nothing in front
// / of a number. It takes a number, and returns a string.
// / Very hardcore.
const PorM = (Number) => {
  if (isNaN(Number)) {
    return '';
  } else
    if (Number === 0) { // dragon pussy
      return '';
    } else if (Number > 0) {
      return '+';
    }
  // } else {
  //   return '-';
  // } // im still calling it porm btw
};

// / A helper function to take in a quirk key and return a quirk object.
// / It takes a quirk key, and retrieves from AllQuirks the quirk object
// / that has that as its Qkey. It returns that object, or some busted
// / debug object if it can't find it. Should always return an object.
const QuirkKey2Obj = (QuirkKey, context) => {
  const { data } = useBackend(context);
  const AllQuirks = data.AllQuirks || [];

  const QuirkObject = AllQuirks.find(Quirk => Quirk.Qkey === QuirkKey);
  return QuirkObject || {
    'Qkey': 'Oh. Ohhhhh no.',
    'Qname': 'Oh no.',
    'Qdesc': 'Wonderful, the key2object thing broke.',
    'Qpath': 'help',
    'Qvalue': 10180085,
    'Qmechanics': 'Makes Dan go augh. Report for discount erp.',
    'Qconflicts': [],
    'Qcategory': 'All Quirks',
    'Qhumanonly' : '👨',
  };
};

// / A helper function for QuirkList to get an array of quirk objects
// / that are in a given category. It takes a category name, and an array
// / of quirk objects, and returns an array of quirk objects.
const GetQuirksInCategory = (props, context) => {
  const { data } = useBackend(context);
  const AllQuirks = data.AllQuirks || [];
  const AllCategories = data.AllCategories || [];
  const CategoryName = props || AllCategories[0] || '';
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', YourQuirks);

  if (SelectedCategory === YourQuirks) {
    return AllQuirks.filter(Quirk => {
      return data.UserQuirkKeys.includes(Quirk.Qkey);
    }) || [
      {
        'Qkey': 'You dont have any!',
        'Qname': 'You don\'t have any quirks!',
        'Qdesc': 'Why don\'t you go get some?',
        'Qpath': 'help',
        'Qvalue': 10180085,
        'Qmechanics': 'They\'re pretty cool!',
        'Qconflicts': [],
        'Qcategory': 'All Quirks',
        'Qhumanonly' : '👨',
      },
    ];
  }


  if (SearchTerm.length > 0) {
    return AllQuirks.filter(Quirk => {
      return Quirk.Qname.toLowerCase().includes(SearchTerm.toLowerCase());
    });
  }

  if (!CategoryName || CategoryName === AllCategories[0]) {
    return AllQuirks; // return em all
  }
  return AllQuirks.filter(Quirk => {
    return Quirk.Qcategory === CategoryName;
  });
};

// / A helper function for QuirkButton to determine if the user has enough
// / quirk points to take this quirk. If the quirk has a value that is 0 or less,
// / it returns true, cus they can always take a negative-value quirk. If the quirk
// / has a positive value, and if taking that quirk would put them over their quirk
// / point limit, it returns false. Otherwise, it returns true.
const UserCanAffordQuirk = (QuirkObject, context) => {
  const { data } = useBackend(context);
  if (QuirkObject.Qvalue <= 0) {
    return true;
  }
  const MaxQuirkPoints = data.MaxQuirkPoints || 0;
  const UserQuirkPoints = data.UserQuirkPoints || 0;

  if (UserQuirkPoints + QuirkObject.Qvalue > MaxQuirkPoints) {
    return false;
  }
  return true;
};

// A helper function for QuirkButton to determine if the user has enough
// / good quirk slots to take this quirk. If the quirk has a value that is 0 or less,
// / it returns true, cus they can always take a negative-value quirk. If the quirk
// / has a positive value, and if taking that quirk would put them over their quirk
// / point limit, it returns false. Otherwise, it returns true.
const UserCanGoodQuirk = (QuirkObject, context) => {
  const { data } = useBackend(context);
  if (QuirkObject.Qvalue <= 0) {
    return true;
  }
  const MaxGoodQuirks = data.MaxGoodQuirks || 0;
  const UserQuirkGoods = data.UserQuirkGoods || 0;

  if (UserQuirkGoods + 1 > MaxGoodQuirks) {
    return false;
  }
  return true;
};

// / A helper function for QuirkButton to determine if the user can remove
// / this quirk. If the quirk has a value that is 0 or more, it returns true,
// / cus they can always remove a positive-value quirk. If the quirk has a negative
// / value, and if removing that quirk would put them over their quirk point limit,
// / it returns false. Otherwise, it returns true.
const UserCanRemoveQuirk = (QuirkObject, context) => {
  const { data } = useBackend(context);
  const MaxQuirkPoints = data.MaxQuirkPoints || 0;
  const UserQuirkPoints = data.UserQuirkPoints || 0;

  if (QuirkObject.Qvalue >= 0) {
    return true;
  }
  if (UserQuirkPoints - QuirkObject.Qvalue > MaxQuirkPoints) {
    return false;
  }
  return true;
};

// / A helper function for QuirkButton to take an array of quirk keys,
// / and return an array of quirk objects.
const QKeyArray2ObjArray = (QuirkKeys, context) => {
  const { data } = useBackend(context);
  const AllQuirks = data.AllQuirks || [];
  const QuirkObjects = [];
  QuirkKeys.forEach(QuirkKey => {
    const QuirkObject = AllQuirks.find(Quirk => Quirk.Qkey === QuirkKey);
    if (QuirkObject) {
      QuirkObjects.push(QuirkObject);
    }
  });
  return QuirkObjects;
};

// / A helper function for QuirkButton to take two arrays and return
// / an array of the elements that are in both arrays.
// / Does not include duplicates
const ArrayIntersection = (Array1, Array2) => {
  const Intersection = Array1.filter(value => Array2.includes(value));
  // / filter duplicates
  return [...new Set(Intersection)];
};

// / Gormless Kong
// / A helper function to make a page bar for the quirk list, so we dont have to
// / render 200 darn buttons at once. It pulls the current page from the
// / local state, and the number of pages from the length of the quirks list.
// / Nah we dont have to truncate the page list, we can just make it a
// / big fat box
const QuirkPageBar = (props, context) => {
  const { act, data } = useBackend(context);
  const AllQuirks = data.AllQuirks || [];
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
  ] = useLocalState(context, 'SelectedCategory', YourQuirks);

  if (SearchTerm === '' && SelectedCategory !== AllCategories[0]) {
    return (<Box />);
  }
  const Cat2Use = SearchTerm ? AllQuirks[0] : SelectedCategory;
  const FilteredAllQuirks = GetQuirksInCategory(Cat2Use, context);

  const TotalPageNum = Math.ceil(FilteredAllQuirks.length / QuirksPerPage);

  const PrevButton = (
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
  const NextButton = (
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

  return (
    <Flex>
      <Flex.Item grow={1} />
      <Flex.Item>
        <Box inline px="1em" py={1}>
          Page {CurrentPage} / {TotalPageNum}
        </Box>
      </Flex.Item>
      <Flex.Item shrink={0}>
        {PrevButton}
        {NextButton}
        <Box inline px="1em" />
      </Flex.Item>
    </Flex>
  );
};










