/* eslint-disable */
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Section, Stack, Fragment, Flex, Icon, Input, NoticeBox, Tooltip, Table } from '../components';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';
const FlirtsPerPage = 10;
const AllFlirts = 'All Flirts';

// yes this is just the quirk menu
// its a good menu okay??

export const FlirtyFlirty = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    FlirterName,
  } = data;
  const AllFlirts = data.AllFlirts || [];
  const AllCategories = data.AllCategories || [];
  const [
    HelpMode,
    setHelpMode,
  ] = useLocalState(context, 'HelpMode', false);
  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', AllFlirts[0]);
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const Cat2Use = SearchTerm ? AllFlirts[0] : SelectedCategory;
  const FilteredAllFlirts = GetFlirtsInCategory(Cat2Use, context);

  return (
    <Window
      theme="ntos"
      width={640}
      height={550}
      resizable>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Section
              width="100%"
              title={"Welcome, " + FlirterName + "!"}
              buttons={(
                <FlirtSearchBar />
              )}>
              <FlirtHeaderThings />
            </Section>
          </Stack.Item>
          <Stack.Item grow={1} basis={1}>
            <Section
              fill
              width="100%"
              scrollable>
              {HelpMode ? (
                <FlirtHelp />
              ) : (
              <Flex direction="row">
                <Flex.Item shrink={0}>
                  <FlirtCategoryList />
                </Flex.Item>
                <Flex.Item grow={1} basis={0}>
                  <FlirtJizz FlirtsinCat={FilteredAllFlirts} />
                </Flex.Item>
              </Flex>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item>
            <FlirtPageBar />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const FlirtHelp = (props, context) => {
  const { act, data } = useBackend(context);

  const BodyStylePro = {
    'background-color': 'rgba(255, 255, 255, 0.1)',
    'border-radius': '10px',
    'padding': '0.5rem',
  };

  const BodyStyleMid = {
    'background-color': 'rgba(255, 255, 255, 0.1)',
    'border-radius': '10px',
    'padding': '0.5rem',
  };

  const BodyStyleWarning = {
    'background-color': 'rgba(255, 255, 255, 0.1)',
    'border-radius': '10px',
    'padding': '0.5rem',
  };

  return (
    <>
      <Box
        p="0.5rem"
        my="0.5rem"
        textAlign="center"
        style={BodyStylePro}
        width="100%">
        <Box
          fontSize="18px"
          color="label">
            HOW TO FLIRT WITH CUTE FOXES
        </Box>
        <Box
          fontSize="8px"
          color="label">
            By Dank Elly the Fox
        </Box>
      </Box>
      <Box style={BodyStylePro}>
        So lets say you see someone you want to get to know a bit better. Maybe
        they're a hot lil critter, or just a really cool person. Problem is,
        you gotta get their attention! Sure, you can just go up to them and
        blurt out your name, but <i>augh</i>, what do you say, what do you
        <i>do</i>? Easy. You flirt with them! But how?
        <br/>
        <br/>
        Flirts are pre-packaged sets of actions that are sent between you and
        whomever you're interested in meeting. They're low-risk and to the point,
        perfect for getting to know someone new.
        <br/>
        <br/>
        To perform a Flirt, just press one of the Flirt buttons on the main page.
        This will do one of two things, depending on if you have a target or not.
        <br/>
        <br/>
        If you have a target, it will just perform the flirt on them.
        <br/>
        <br/>
        If you don't, it will spawn you a Flirt Item. You can click on someone
        with this item, and it will perform the flirt on them at any range, or
        you can click on it in-hand to broadcast a non-specific version of the
        Flirt to everyone nearby.
        <br/>
        <br/>
        So, targetting! If you want to target someone, just click the button
        in the upper half of the window, can't miss it! When you do this, if you
        don't have a target, it will spawn you a Flirt Targetter, and with that,
        just click someone to target them.
        <br/>
        <br/>
        If you do have a target, clicking this button will clear your target.
        Your target is also cleared after you perform a flirt on them.
        <br/>
        <br/>
        You can <i>also</i> right-click someone and click "Flirt with" to target
        them and open this window. You can also use the *flirt emote to open
        this window, though it won't target anyone by default.
      </Box>
      <Box style={BodyStyleWarning}>
        <b>Keep in mind</b>:
      <Box style={BodyStylePro}>
        Read their OOC notes first and respect their preferences! Basically don't
        be a creep... unless they want that =3
      </Box>
    </Box>
  </>
  );
}

// Has the person you're flirting with, if any
// Also a button to clear that or pick someone or something
const FlirtHeaderThings = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    FlirterCkey,
    TargetName,
    TargetCkey,
    FlirtedName,
  } = data;

  const HasTarget = TargetName !== "AAABAD";
  const HasFlirted = TargetName !== "AAABAD";
  const TargNameReal = HasTarget ? TargetName : "No one (yet!)";
  const FlirtedNameReal = HasFlirted ? FlirtedName : "No one (yet!)";
  const HelpText = "How do I flirt?";

  return (
    <Flex direction="row">
      <Flex.Item grow={1}>
        <Box textAlign="left" fontSize="14px" color="label">
          You last flirted with:
          <Button
            content={TargNameReal}
            onClick={() => act(( 'ClearFlirtTarget'), {
              'ReturnFlirterCkey': FlirterCkey,
              'ReturnTargetCkey': TargetCkey,
            })} />
        </Box>
        {/* <Box textAlign="left" fontSize="14px" color="label">
          <Button
            content={FlirtedNameReal}
            onClick={() => act(( 'ClearFlirtRecipient'), {
              'ReturnFlirterCkey': FlirterCkey,
              'ReturnTargetCkey': TargetCkey,
            })} />
            last flirted with you!
        </Box> */}
      </Flex.Item>
      <Flex.Item shrink={0}>
        <Button
          tooltip={HelpText}
          icon="info-circle"
          fontSize="14px"
          color="good"
          onClick={toggleHelpMode(props, context)} />
      </Flex.Item>
    </Flex>
  );
};

// toggles the help mode
const toggleHelpMode = (props, context) => {
  const [
    HelpMode,
    setHelpMode,
  ] = useLocalState(context, 'HelpMode', false);

  return () => {
    setHelpMode(!HelpMode);
  };
}


// The search bar at the top of the window.
// Its a search bar! You can look up anything, so long as its the name
// of a quirk. or dragon pussy. I've promised it across like 3 PRs now,
// Ive gotta deliver at some point.
const FlirtSearchBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    DP,
  } = data;
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const FillerText = DP ? "Dragon Pussy" : "Find-A-Flirt 0.1b (tm)";

  return (
    <Box inline width="fit-content">
      <Input
        width="15em"
        placeholder={FillerText}
        value={SearchTerm}
        onChange={(e, value) => {
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
  ] = useLocalState(context, 'SelectedCategory', AllCategories[0]);
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
// in AllFlirts, and the selected category is stored in the local state.
// We'll add on one additional tab at the end, not clickable, that
// will be the tally for all the quirk points you've spent and have left!
const FlirtCategoryList = (props, context) => {
  const { act, data } = useBackend(context);
  const AllCategories = data.AllCategories || [];

  return (
    <Box
      p="0.5rem"
      mr="0.5rem"
      width="fit-content"
      backgroundColor="#2f2f2f">
      {AllCategories.map(category => (
        <FlirtTab CatName={category} key={category} />
      ))}
    </Box>
  );
}; // not that big of a proc actually

// / One of the tabs in the category list. Its a tab! It has a name!
// / It also counts up the point value of all those quirks.
// / That value can be negative btw, if you've taken more negative quirks
// / than positive ones.
const FlirtTab = (props, context) => {
  const { act, data } = useBackend(context);
  const CatName = props.CatName || "Oh no";

  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', AllFlirts);
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
        act('Sound', {
          'DoSound': 'TabClick',
        }); }}>
      <Box
        inline
        textAlign={'left'}>
        {CatName}
      </Box>
    </Button>
  );
};

// The big holder of the quirks! Its a long column of big cool buttons
// that you can click on to select a quirk. The quirks are defined
// in AllFlirts, and any selected quirks are defined in UserQuirks.
// the current category is stored in the local state.
// the category defines what quirks to show. If the category is AllFlirts[0],
// it will show all the quirks in AllFlirts.
const FlirtJizz = (props, context) => {
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
  ] = useLocalState(context, 'SelectedCategory', AllFlirts);

  const FilteredAllFlirts = GetFlirtsInCategory(SelectedCategory, context);

  const Paginate = true;
  const ShowRange = Paginate ? [CurrentPage * FlirtsPerPage - FlirtsPerPage, CurrentPage * FlirtsPerPage] : [0, FilteredAllFlirts.length];
  const ShowFlirts = FilteredAllFlirts.slice(ShowRange[0], ShowRange[1]);

  const WhyIsItEmpty = SearchTerm
    ? "No Flirts found!"
    : SelectedCategory === AllCategories[0]
      ? "Congratulations! You've been selected to open an issue on Github! Use the keyword 'Dragon Pussy' for 15% off your tech support!"
      : "No Flirts in this category!";

  return (
    <Box>
      {ShowFlirts.length === 0 && (
        <NoticeBox active>
          {WhyIsItEmpty}
        </NoticeBox>
      )}

      {ShowFlirts.map(Flirt => (
        <Box
          key={Flirt.FlirtKey}
          mr="0.5em"
          mb="0.5em">
          <FlirtButton FOBJ={Flirt} />
        </Box>
      ))}
    </Box>
  );
};

// / One of the buttons in the quirk list. Its a button! It has a name!
const FlirtButton = (props, context) => {
  const { act, data } = useBackend(context);
  /// Who lives in a javascript under the sea?
  //const UserQuirksConflictingKeys = data.UserQuirksConflictingKeys || [];
  const FlirterCkey = data.FlirterCkey || 'Guest';
  const TargetCkey = data.TargetCkey || 'Buddy';

  const FlirtObj = props.FOBJ || {
    'FlirtKey': 'Oh. Ohhhhh no.',
    'FlirtName': 'Oh no.',
    'FlirtDesc': 'ha ha, great flirting lagg',
    'FlirtSound': false,
  };

  const FlirtKey = FlirtObj.FlirtKey || 'Oh. Ohhhhh no.';
  const FlirtName = FlirtObj.FlirtName || 'Generic Pickup Line';
  const FlirtDesc = FlirtObj.FlirtDesc || 'Probably do nothing, this is broke';
  const HasFlirtSound = !!FlirtObj.FlirtSound || false;

  const BGColor = "";
  const TextColor = "white";

  return (
    <Flex direction="row">
      <Flex.Item grow={1}>
        <Button
          fluid
          px="0.5rem"
          py="0.5rem"
          mx="0.1rem"
          // style={{
          //   'background-image': 'linear-gradient(#222244, #444466, #444466, #222244)',
          // }}
          textColor={TextColor}
          backgroundColor={BGColor}
          tooltip={FlirtDesc}
          onClick={() =>
            act('ClickedFlirtButton', {
              'ReturnFlirtKey': FlirtKey,
              'ReturnFlirterCkey': FlirterCkey,
              'ReturnTargetCkey': TargetCkey,
            })
          } >
          <Box
            inline
            textAlign={'left'}>
              {FlirtName}
          </Box>
        </Button>
      </Flex.Item>
      <Flex.Item shrink={1}> {/* preview button */}
        <Button
          px="0.5rem"
          py="0.5rem"
          mx="0.1rem"
          BGColor={BGColor}
          tooltip="Preview what this'll look like!"
          textAlign={'center'}
          icon="eye"
          onClick={() =>
            act('PreviewFlirt', {
              'ReturnFlirtKey': FlirtKey,
              'ReturnFlirterCkey': FlirterCkey,
              'ReturnTargetCkey': TargetCkey,
            })}
          />
      </Flex.Item>
      <Flex.Item> {/* sound button */}
        <Button
          px="0.5rem"
          py="0.5rem"
          mx="0.1rem"
          disabled={!HasFlirtSound}
          icon="volume-up"
          tooltip="Preview the sound!"
          onClick={() =>
            act('PreviewSound', {
              'ReturnFlirterCkey': FlirterCkey,
              'ReturnFlirtKey': FlirtKey,
            })
          } />
      </Flex.Item>
    </Flex>
  );
};


// / A helper function for QuirkList to get an array of quirk objects
// / that are in a given category. It takes a category name, and an array
// / of quirk objects, and returns an array of quirk objects.
const GetFlirtsInCategory = (props, context) => {
  const { data } = useBackend(context);
  const AllFlirts = data.AllFlirts || [];
  const AllCategories = data.AllCategories || [];
  const CategoryName = props || AllCategories[0] || '';
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const [
    SelectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'SelectedCategory', AllFlirts);


  if (SearchTerm.length > 0) {
    return AllFlirts.filter(Quirk => {
      return Quirk.FlirtName.toLowerCase().includes(SearchTerm.toLowerCase());
    });
  }

  if (!CategoryName || CategoryName === AllCategories[0]) {
    return AllFlirts; // return em all
  }
  return AllFlirts.filter(Quirk => {
    return Quirk.FlirtCategories.includes(CategoryName);
  });
};

// / Gormless Kong
// / A helper function to make a page bar for the quirk list, so we dont have to
// / render 200 darn buttons at once. It pulls the current page from the
// / local state, and the number of pages from the length of the quirks list.
// / Nah we dont have to truncate the page list, we can just make it a
// / big fat box
const FlirtPageBar = (props, context) => {
  const { act, data } = useBackend(context);
  const AllFlirts = data.AllFlirts || [];
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
  ] = useLocalState(context, 'SelectedCategory', AllFlirts);

  // if (SearchTerm === '' && SelectedCategory !== AllCategories[0]) {
  //   return (<Box />);
  // }
  const Cat2Use = SearchTerm ? AllFlirts[0] : SelectedCategory;
  const FilteredAllFlirts = GetFlirtsInCategory(Cat2Use, context);

  const TotalPageNum = Math.ceil(FilteredAllFlirts.length / FlirtsPerPage);

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











