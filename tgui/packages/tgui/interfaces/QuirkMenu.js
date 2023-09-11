/* eslint-disable max-len */
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Section, Stack, Fragment, Flex, Icon, Input, NoticeBox } from '../components';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';
const YourQuirks = 'Your Quirks'

// The primary window, holds two sections:
// the left section is the list of categories in AllQuirks,
// the right section is the list of quirks in the selected category,
// populated the list of quirks in AllQuirks's selected category.
// Will also include a search bar at the top of the window.
// But we're geting ahead of ourselves! Let's start with the top-level
// Window skeleton!
/// AllQuirks format:
///  [
///    {
///      'Qkey' : string,
///      'Qname' : string,
///      'Qdesc' : string,
///      'Qpath' : string,
///      'Qvalue' : number,
///      'Qdesc' : string,
///      'Qmechanics' : string,
///      'Qconflicts' : array,
///      'Qcategory' : string
///    },
///  ], ...
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
  ] = useLocalState(context, 'SelectedCategory', AllCategories[0]);
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

  return(
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
              width = "100%"
              scrollable>
              <Flex direction="row">
                <Flex.Item shrink={0}>
                  <QuirkCategoryList />
                </Flex.Item>
                <Flex.Item grow={1} basis={0}>
                  {FilteredAllQuirks.length === 0 && (
                    <NoticeBox active={true}>
                      {WhyIsItEmpty}
                    </NoticeBox>
                  ) || (
                  FilteredAllQuirks.map(Quirk => (
                    <Box
                      key={Quirk.Qkey}
                      mr="0.5em"
                      mb="0.5em">
                      <QuirkButton QOBJ={Quirk} />
                    </Box>
                  )))}
                </Flex.Item>
              </Flex>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Box />
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

  return(
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
            onClick={() => act('ResetQuirks', {
              'UserCkey' : UserCkey,
              'DoSound' : "ResetQuirks",
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
              'UserCkey' : UserCkey,
              'DoSound' : "SaveQuirks",
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
  } = data;
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');

  return(
    <Box inline width="fit-content">
      <Input
        width="15em"
        placeholder="Find-A-Quirk 0.1b (tm)"
        value={SearchTerm}
        onInput={(e, value) =>
          setSearchTerm(sanitizeText(value)),
          act('Sound', {
            'DoSound' : 'SearchType',
          })
        } />
      <Button
        color="transparent"
        tooltip="Clear search"
        onClick={() =>
        setSearchTerm(''),
        act('Sound', {
          'DoSound' : 'SearchClear',
        })} >
        <Icon
          name="times"
          color="label" />
      </Button>
    </Box>
  );
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
  const AllerCats = [Firstie, YourQuirks].concat(AllcatsMinusTheFirst);

  return(
    <Box
      p="0.5rem"
      mr="0.5rem"
      width="fit-content"
      backgroundColor="#2f2f2f">
			{AllerCats.map(category => (
				<QuirkTab CatName={category} />
			))}
		</Box>
  );
}; // not that big of a proc actually

/// One of the tabs in the category list. Its a tab! It has a name!
/// It also counts up the point value of all those quirks.
/// That value can be negative btw, if you've taken more negative quirks
/// than positive ones.
const QuirkTab = (props, context) => {
  const { act, data } = useBackend(context);
  const AllQuirks = data.AllQuirks || [];
  const UserQuirks = data.UserQuirks || [];
  const CatName = props.CatName || "Oh no";

  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', AllQuirks[0]);

  const FilteredAllQuirks = GetQuirksInCategory(CatName, context);
  let TotalQuirkValue = 0;
  FilteredAllQuirks.forEach(Quirk => {
    if(UserQuirks.includes(Quirk.Qkey)) {
      TotalQuirkValue += Quirk.Qvalue;
    }
  });

  const PlusOrMinus = TotalQuirkValue == 0 ? '' : TotalQuirkValue > 0 ? '+' : '-';

  return(
    <Button
      key={CatName}
      fluid
      px="0.5em"
      py="0.25em"
      selected={SelectedCategory === CatName}
      onClick={() =>
        setSelectedCategory(CatName),
        act('Sound', {
          'DoSound' : 'TabClick',
        })}>
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
            color={TotalQuirkValue == 0 ? 'label' : TotalQuirkValue > 0 ? 'good' : 'bad'}
            textAlign={'right'}>
            {PlusOrMinus}{TotalQuirkValue}
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


/// One of the buttons in the quirk list. Its a button! Its full of text!
/// Click it, and it'll tell BYOND to give the player that quirk.
/// It contains: the name of the quirk, the point value of the quirk,
/// a flavor text description of the quirk, a mechanics description of the
/// quirk, and a list of quirks that conflict with this one.
/// AllQuirks format:
///  [
///    {
///      'Qkey' : string,
///      'Qname' : string,
///      'Qdesc' : string,
///      'Qpath' : string,
///      'Qvalue' : number,
///      'Qdesc' : string,
///      'Qmechanics' : string,
///      'Qconflicts' : array,
///      'Qcategory' : string
///    },
///  ], ...
const QuirkButton = (props, context) => {
  const { act, data } = useBackend(context);
  const UserQuirkKeys = data.UserQuirkKeys || [];
  const UserCkey = data.UserCkey || 'Guest';
  const UserName = data.UserName || 'Buddy';

  const QuirkObj = props.QOBJ || {
    'Qkey' : 'Oh. Ohhhhh no.',
    'Qname' : 'Oh no.',
    'Qdesc' : 'Wonderful, QuirkButton thing broke.',
    'Qpath' : 'help',
    'Qvalue' : 10180085,
    'Qmechanics' : 'Makes Dan go augh. Report for expensive dragon pussy.',
    'Qconflicts' : [],
    'Qcategory' : 'All Quirks',
  };

  const QuirkKey = QuirkObj.Qkey || "!";
  const QuirkName = QuirkObj.Qname || "Quirk";
  const QuirkValue = QuirkObj.Qvalue || 0;
  const PlusOrMinus = PorM(QuirkValue) || '';
  const QuirkDesc = QuirkObj.Qdesc || "This is a quirk! Not much is known about it!";
  const QuirkMechanics = QuirkObj.Qmechanics || "Supposedly does something!";
  const QuirkConflicts = QuirkObj.Qconflicts || []; // this is an array!

  const UserConflictObjects = GetUserConflictObjects(QuirkConflicts, context);
  const UserHasQuirk = UserQuirkKeys.includes(QuirkKey);
  const CanTakeIt = UserCanTakeQuirk(QuirkObj, UserConflictObjects, UserHasQuirk, context);
  const CanAffordIt = QuirkValue + data.UserQuirkPoints <= data.MaxQuirkPoints;
  const CanGoodIt = QuirkValue > 0 && data.UserQuirkGoods + 1 < data.MaxGoodQuirks;

  const TitleColor = !CanTakeIt && !UserHasQuirk ? 'bad' : 'white' ;
  const BGColor = UserHasQuirk ? "#448844" : CanTakeIt ? "" : "#884444";

  let SoundAct = "Generic"
  if(UserHasQuirk) {
    SoundAct = "RemoveQuirk";
  } else if(CanTakeIt) { // cantakeit assumes they can afford it
    SoundAct = "AddQuirk";
  } else if(!CanAffordIt) {
    SoundAct = "CantAfford";
  } else if(!CanGoodIt) {
    SoundAct = "TooManyGood";
  } else if(UserConflictObjects.length > 0) {
    SoundAct = "Conflicts";
  }

  return(
      <Button
        px="1rem"
        py="1rem"
        mb="0.5rem"
        mx="0.5rem"
        width = "100%"
        selected={UserHasQuirk}
        disabled={!CanTakeIt && !UserHasQuirk} // if you have it, you can unhave it
        textAlign="left"
        backgroundColor = {BGColor}
        onClick={() =>
          act('ClickQuirk', {
            'QuirkKey' : QuirkKey,
            'UserCkey' : UserCkey,
            'UserName' : UserName,
            'DoSound' : SoundAct,
          })
        }>
        <NoticeBox
          active={!CanTakeIt && !UserHasQuirk}
          width = "100%">

          <Box
            style={{
              'border-bottom': '1px solid white',
            }}
            textAlign="left"
            bold={true}
            fontSize="18px"
            mb="0.5rem"
            color={TitleColor}>
            <Flex direction="row">
              <Flex.Item basis="3em">
                <Box
                  color={
                    QuirkValue == 0
                    ? 'label'
                    : QuirkValue > 0
                      ? 'good'
                      : 'bad'
                      }>
                    {PlusOrMinus}{QuirkValue}
                </Box>
              </Flex.Item>
              <Flex.Item grow={1}>
                {QuirkName}
              </Flex.Item>
            </Flex>
          </Box>
      {UserConflictObjects.length > 0 && (
          <ConflictBox UserConflictObjects={UserConflictObjects} />
      )}
        <Box
          textAlign="left"
          fontSize="12px">
          {QuirkDesc}
        </Box>
        <Box
          textAlign="left"
          fontSize="10px"
          color="label"
          dangerouslySetInnerHTML={{__html: QuirkMechanics}} />
      </NoticeBox>
    </Button>
  );
};

/// Makes a cute little box with an exclamation point and the name of
/// a quirk that conflicts with the quirk you're trying to take.
const QuirkConflict = (QuirkObject) => {
  const QuirkName = QuirkObject.Qname || "Some quirk";
  return(
    <Button
      fluid
      backgroundColor="bad"
      textAlign="left"
      tooltip={QuirkName + " is incompatible with this one!"}
      tooltipPosition="left">
      <Icon
        name="exclamation-triangle"
        color="bad" />
      {QuirkName}
    </Button>
  );
};

/// A helper function for QuirkButton to make a box with a list of
/// quirk objects that conflict with this quirk. It takes an array of
/// quirk objects, and returns a box with a list of quirk names.
const ConflictBox = (UserConflictObjects) => {
  return(
    <Stack.Item>
      <Box color="bad">
        !!! You have quirks that prevent this one from being taken !!!<br />
        <b>Conflicts With:</b><br />
        {UserConflictObjects.map(conflict => (
          QuirkConflict(conflict)
        ))}
      </Box>
    </Stack.Item>
  );
};

/// A helper function for QuirkButton to get an array of quirk objects
/// that conflict with this quirk. It takes an array of quirk keys,
/// and returns an array of quirk objects.
/// with it, and false if they don't.
const GetUserConflictObjects = (QuirkKeys, context) => {
  const { data } = useBackend(context);
  const AllQuirks = data.AllQuirks || [];

  const UserConflictObjects = [];
  QuirkKeys.forEach(QuirkKey => {
    const QuirkObject = AllQuirks.find(Quirk => Quirk.Qkey === QuirkKey);
    if(QuirkObject) {
      UserConflictObjects.push(QuirkObject);
    }
  });
  return UserConflictObjects;
};

/// A helper function for QuirkButton to put a +, -, or nothing in front
/// of a number. It takes a number, and returns a string.
/// Very hardcore.
const PorM = (Number) => {
  if(Number == 0) { // dragon pussy
    return '';
  } else if(Number > 0) {
    return '+';
  }
  // } else {
  //   return '-';
  // } // im still calling it porm btw
};

/// A helper function to take in a quirk key and return a quirk object.
/// It takes a quirk key, and retrieves from AllQuirks the quirk object
/// that has that as its Qkey. It returns that object, or some busted
/// debug object if it can't find it. Should always return an object.
const QuirkKey2Obj = (QuirkKey, context) => {
  const { data } = useBackend(context);
  const AllQuirks = data.AllQuirks || [];

  const QuirkObject = AllQuirks.find(Quirk => Quirk.Qkey === QuirkKey);
  return QuirkObject || {
    'Qkey' : 'Oh. Ohhhhh no.',
    'Qname' : 'Oh no.',
    'Qdesc' : 'Wonderful, the key2object thing broke.',
    'Qpath' : 'help',
    'Qvalue' : 10180085,
    'Qmechanics' : 'Makes Dan go augh. Report for discount dragon pussy.',
    'Qconflicts' : [],
    'Qcategory' : 'All Quirks',
  };
};

/// A helper function for QuirkList to get an array of quirk objects
/// that are in a given category. It takes a category name, and an array
/// of quirk objects, and returns an array of quirk objects.
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
  ] = useLocalState(context, 'SelectedCategory', AllCategories[0]);

  if(SelectedCategory === YourQuirks) {
    return AllQuirks.filter(Quirk => {
      return data.UserQuirkKeys.includes(Quirk.Qkey);
    }) || [
      {
        'Qkey' : 'You dont have any!',
        'Qname' : 'You don\'t have any quirks!',
        'Qdesc' : 'Why don\'t you go get some?',
        'Qpath' : 'help',
        'Qvalue' : 10180085,
        'Qmechanics' : 'They\'re pretty cool!',
        'Qconflicts' : [],
        'Qcategory' : 'All Quirks',
      },
    ];
  }


  if(SearchTerm.length > 0) {
    return AllQuirks.filter(Quirk => {
      return Quirk.Qname.toLowerCase().includes(SearchTerm.toLowerCase());
    }) || [
      {
        'Qkey' : 'Great, the quirk search proc doesnt work.',
        'Qname' : 'Great, the quirk search proc doesnt work.',
        'Qdesc' : 'Great, the quirk search proc doesnt work.',
        'Qpath' : 'help',
        'Qvalue' : 10180085,
        'Qmechanics' : 'Makes Dan go augh. Report for free dragon pussy.',
        'Qconflicts' : [],
        'Qcategory' : 'All Quirks',
      },
    ];
  }

  if(!CategoryName || CategoryName === AllCategories[0]) {
    return AllQuirks; // return em all
  }
  const FilteredAllQuirks = AllQuirks.filter(Quirk => {
    return Quirk.Qcategory === CategoryName;
  });
  return FilteredAllQuirks || [
    {
      'Qkey' : 'Great, the quirk category proc doesnt work.',
      'Qname' : 'Great, the quirk category proc doesnt work.',
      'Qdesc' : 'Great, the quirk category proc doesnt work.',
      'Qpath' : 'help',
      'Qvalue' : 10180085,
      'Qmechanics' : 'Makes Dan go augh. Report for free dragon pussy.',
      'Qconflicts' : [],
      'Qcategory' : 'All Quirks',
    },
  ];
};

/// A helper function for QuirkButton to determine if the user can actually
/// take this quirk. It takes a quirk object, an array of conflicting quirks,
/// and a boolean for if the user already has this quirk. It returns true
/// if the user can take this quirk, and false if they can't.
const UserCanTakeQuirk = (QuirkObject, UserConflictObjects, UserHasQuirk, context) => {
  if(!!UserHasQuirk || UserConflictObjects.length > 0) {
    return false; // ezpz
  }
  const { data } = useBackend(context);
  const MaxQuirkPoints = data.MaxQuirkPoints || 0;
  const MaxGoodQuirks = data.MaxGoodQuirks || 0;
  const UserQuirkPoints = data.UserQuirkPoints || 0;
  const UserQuirkGoods = data.UserQuirkGoods || 0;

  if(UserHasQuirk) {
    return false;
  }
  if(QuirkObject.Qvalue > 0 && UserQuirkGoods >= MaxGoodQuirks) {
    return false;
  }
  if(QuirkObject.Qvalue + UserQuirkPoints > MaxQuirkPoints) {
    return false;
  }
  return true;
};

