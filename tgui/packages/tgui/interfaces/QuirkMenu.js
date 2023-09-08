/* eslint-disable max-len */
import { map } from 'common/collections';
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Section, Stack, Tabs, Icon, Input } from '../components';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';

// The primary window, holds two sections:
// the left section is the list of categories in QuirkData,
// the right section is the list of quirks in the selected category,
// populated the list of quirks in QuirkData's selected category.
// Will also include a search bar at the top of the window.
// But we're geting ahead of ourselves! Let's start with the top-level
// Window skeleton!
export const QuirkMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserName,
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
    <Window
      width={1024}
      height={768}
      resizable>
      <Window.Content>
        <Section
          title={"Welcome, " + UserName + "! Lets set up your quirks!"}
          buttons={(
            <QuirkSearchBar />
          )}>
          <Box
            textAlign="center"
            fontSize="14px"
            color="label">
            <b>Quirk Points:</b> {QuirkPointReadout} / {MaxQuirkPoints} <br />
            <b>Good Quirks:</b> {QuirkGoodReadout} / {MaxGoodQuirks}
            <hr />
          </Box>
          <Stack fill>
            <Stack.Item>
              <QuirkCategoryList />
            </Stack.Item>
            <Stack.Item grow>
              <QuirkList />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

// The search bar at the top of the window.
// Its a search bar! You can look up anything, so long as its the name
// of a quirk. or dragon pussy. I've promised it across like 3 PRs now,
// Ive gotta deliver at some point.
const QuirkSearchBar = (props, context) => {
  const { act, data } = useBackend(context);
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', QuirkData[0].name);

  return(
    <Box inline>
      <Input
        placeholder="Search for a quirk..."
        value={SearchTerm}
        onChange={(e, value) =>
          setSearchTerm(sanitizeText(value)),
          setSelectedCategory("All")
        } />
      <Button
        color="transparent"
        tooltip="Clear search"
        onClick={() => setSearchTerm('')} >
        <Icon
          name="times"
          color="label" />
      </Button>
    </Box>
  );
};

// The big holder of the categories! Its a long column of tabs that
// you can click on to select a category. The categories are defined
// in QuirkData, and the selected category is stored in the local state.
// We'll add on one additional tab at the end, not clickable, that
// will be the tally for all the quirk points you've spent and have left!
const QuirkCategoryList = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    QuirkData,
  } = data;

  return(
    <Tabs vertical>
      <QuirkTab category={category.name} />
      {QuirkData.map(category => (
        <QuirkTab category={category.name} />
      ))}
      <hr />
      <QuirkTabTotal />
    </Tabs>
  );
}; // not that big of a proc actually

/// One of the tabs in the category list. Its a tab! It has a name!
/// It also counts up the point value of all those quirks.
/// That value can be negative btw, if you've taken more negative quirks
/// than positive ones.
const QuirkTab = (CatName, context) => {
  const { data } = useBackend(context);
  const { QuirkData } = data;
  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', QuirkData[0].name);

  const TotalQuirkValue = TabulateQuirkValue(CatName);
  const PlusOrMinus = TotalQuirkValue == 0 ? '' : TotalQuirkValue > 0 ? '+' : '-';

  return(
    <Tabs.Tab
      key={MyCat}
      selected={SelectedCategory === CatName}
      onClick={() => setSelectedCategory(CatName)}>
        <Flex direction="row">
          <Flex.Item grow={1}>
            <Box
              inline
              color={TotalQuirkValue == 0 ? 'label' : TotalQuirkValue > 0 ? 'good' : 'bad'}
              textAlign={'left'}>
              {CatName}
            </Box>
          </Flex.Item>
          <Flex.Item>
            <Box
              inline
              color={TotalQuirkValue == 0 ? 'label' : TotalQuirkValue > 0 ? 'good' : 'bad'}
              textAlign={'right'}>
              {PlusOrMinus}{TotalQuirkValue}
            </Box>
          </Flex.Item>
        </Flex>
    </Tabs.Tab>
  );
};

/// The tab that shows the total quirk value. Its a tab! It has a name!
/// It also counts up the point value of all the quirks the user has taken.
/// That value can be negative btw, if you've taken more negative quirks
/// than positive ones.
const QuirkTabTotal = (props, context) => {
  const TotalQuirkValue = TabulateQuirkValue("Total");
  const PlusOrMinus = TotalQuirkValue == 0 ? '' : TotalQuirkValue > 0 ? '+' : '-';

  return(
    <Tabs.Tab
      key={"Total"} // oh yeah this one can't be selected
      selected={false}>
        <Flex direction="row">
          <Flex.Item grow={1}>
            <Box
              inline
              color={TotalQuirkValue == 0 ? 'label' : TotalQuirkValue > 0 ? 'good' : 'bad'}
              textAlign={'left'}>
              {"Total"}
            </Box>
          </Flex.Item>
          <Flex.Item>
            <Box
              inline // dragon pussy
              color={TotalQuirkValue == 0 ? 'label' : TotalQuirkValue > 0 ? 'good' : 'bad'}
              textAlign={'right'}>
              {PlusOrMinus}{TotalQuirkValue}
            </Box>
          </Flex.Item>
        </Flex>
    </Tabs.Tab>
  );
};

// The big holder of the quirks! Its a long column of big cool buttons
// that you can click on to select a quirk. The quirks are defined
// in QuirkData, and any selected quirks are defined in UserQuirks.
// the current category is stored in the local state.
// the category defines what quirks to show. If the category is "All",
// it will show all the quirks in QuirkData.

const QuirkList = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    QuirkData,
    UserQuirks,
  } = data;

  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', QuirkData[0].name);

  const FilteredQuirkData = QuirkData.filter(quirk => (
    quirk.Qcat === SelectedCategory
  ));


  return(
    <Stack fill vertical>
      {FilteredQuirkData.length === 0 && (
        <Stack.Item grow>
          <NoticeBox>
            {SelectedCategory === "All"
              ? "Gee, there dont seem to be any quirks! like, at all. Wierd."
              : "Gee, there dont seem to be any quirks in this category! like, at all. Wierd."}
          </NoticeBox>
        </Stack.Item>
      ) || (
        FilteredQuirkData.map(quirk => (
          <QuirkButton quirk={quirk.Qkey} cat={SelectedCategory} />
        ))
      )}
    </Stack>
  );
};

/// One of the buttons in the quirk list. Its a button! Its full of text!
/// Click it, and it'll tell BYOND to give the player that quirk.
/// It contains: the name of the quirk, the point value of the quirk,
/// a flavor text description of the quirk, a mechanics description of the
/// quirk, and a list of quirks that conflict with this one.
// here's the format of QuirkData:
// [ quirk_key : {
//     Qkey : string,
//     Qname : string,
//     Qdesc : string,
//     Qpath : string,
//     Qvalue : number,
//     Qdesc : string,
//     Qmechanics : string,
//     Qconflicts : string,
//     Qcategory : string
//   }, ... ]
// and here's the format of UserQuirks:
// [ quirk_key_1, quirk_key_2, ... ]
// Yeah that ones a lot smaller~
const QuirkButton = (QuirkKey, context) => {
  const { act, data } = useBackend(context);
  const {
    MaxQuirkPoints,
    MaxGoodQuirks,
    AllQuirks, // the flat heckhuge list of all quirks
    UserQuirkKeys,
    UserQuirkPoints,
    UserQuirkGoods,
    UserCkey, // the ckey of the user, to tell BYOND who to give the quirk to
  } = data;
  const Quirk = AllQuirks[QuirkKey];

  const QuirkName = Quirk.Qname || "Quirk";
  const QuirkValue = Quirk.Qvalue || 0;
  const PlusOrMinus = QuirkValue == 0 ? '' : QuirkValue > 0 ? '+' : '-';
  const QuirkDesc = Quirk.Qdesc || "This is a quirk! Not much is known about it!";
  const QuirkMechanics = Quirk.Qmechanics || "Supposedly does something!";
  const QuirkConflicts = Quirk.Qconflicts || []; // this is an array!

  const UserHasConflictingQuirk = UserQuirkKeys.some(quirk => (
    QuirkConflicts.includes(quirk)
    ));
  // const UserConflictingQuirkName = UserQuirkKeys.find(quirk => (
  //   QuirkConflicts.includes(quirk)
  //   ));

  const QuirkIsSelected = UserQuirkKeys.includes(QuirkKey);

  const UserCantAffordQuirk = (
    UserQuirkPoints + QuirkValue > MaxQuirkPoints
  ) || (
    QuirkValue > 0 && UserQuirkGoods + 1 > MaxGoodQuirks
  );

  return(
    <Button
      key={QuirkKey}
      fluid
      height="fit-content"
      textAlign="left"
      selected={QuirkIsSelected}
      disabled={UserHasConflictingQuirk || UserCantAffordQuirk}
      onClick={() => act('SelectQuirk', {
        Quirk: QuirkKey,
        Ckey: UserCkey,
      })}>
      <Section
        title={QuirkName}
        buttons={(
          <Box
            inline
            color={QuirkValue == 0 ? 'label' : QuirkValue > 0 ? 'good' : 'bad'}
            textAlign={'right'}>
            {PlusOrMinus}{QuirkValue}
          </Box>
        )}>
        <Stack fill>
          {UserConflictingQuirkKey && (
            <Stack.Item>
              <Box textAlign="center" color="bad">
                !!UNAVAILABLE!! <br />
                <b>Conflicts With:</b><br />
                <Icon
                  name="exclamation-triangle"
                  color="bad" />
                {AllQuirks[UserConflictingQuirkKey].Qname}
              </Box>
            </Stack.Item>
          )}
          <Stack.Item grow>
            <Box fluid>
              {QuirkDesc}
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Box fluid>
              <b>Specifics:</b><br />
              {QuirkMechanics}
            </Box>
          </Stack.Item>
          {QuirkConflicts.length > 0 && (
            <Stack.Item>
              <Box color="bad">
                <b>Conflicts With:</b><br />
                {QuirkConflicts.map(conflict => (
                  QuirkConflict(conflict)
                ))}
              </Box>
            </Stack.Item>
          )}
        </Stack>
      </Section>
    </Button>
  );
};

/// A helper function for QuirkButton to get the name of a conflicting
/// quirk. It takes a quirk key, and returns a box with the name of the
/// quirk, and an icon indicating its a conflict
const QuirkConflict = (QuirkKey, context) => {
  const { data } = useBackend(context);
  const { AllQuirks } = data;

  const Quirk = AllQuirks[QuirkKey];
  const QuirkName = Quirk.Qname;

  return(
    <Box>
      <Icon
        name="exclamation-triangle"
        color="bad" />
      {QuirkName}
    </Box>
  );
}


/// Reads a player's selected quirks in a given category, and sums up
/// the point value of all those quirks. Returns a number!
/// If CatName is "Total", it will sum up all the quirks in all the
/// categories.
const TabulateQuirkValue = (CatName, context) => {
  const { act, data } = useBackend(context);
  const { UserQuirks } = data;

  if (CatName === "Total") {
    return UserQuirks.reduce((total, quirk) => (
      total + quirk.Qvalue
    ), 0);
  }
  return UserQuirks.filter(quirk => (
    quirk.Qcat === CatName
  )).reduce((total, quirk) => (
    total + quirk.Qvalue
  ), 0);
}
