/* eslint-disable */
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Section, Stack, Flex, Fragment, Input, NoticeBox, Table, LabeledList } from '../components';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';
const YourWhos = {
  WhoIsDummy: true,
};

// The primary window, holds two sections:
// the left section is the list of ckeys in AllWhos,
// the right section is the list of bois in the selected category,
// populated the list of bois in AllWhos's selected category.
// Will also include a search bar at the top of the window.
// But we're geting ahead of ourselves! Let's start with the top-level
// Window skeleton!
// / AllWhos format:
///  [
// /    {
//        'WhoCkey' = string,
//        'WhoName' = {
//          'RealVal' = string,
//          'CustVal' = string,
//          'IsBanned' = bool,
//        },
//        'WhoRole' = {
//          'RealVal' = string,
//          'CustVal' = string,
//          'IsBanned' = bool,
//        },
//        'WhoWhere' = {
//          'RealVal' = string,
//          'CustVal' = string,
//          'IsBanned' = bool,
//        },...
// /    },...
// /  ], ...
export const WhoAdminPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    UserName,
  } = data;
  const AllWhos = data.AllWhos || [];
  const [
    SelectedWho,
    setSelectedWho,
  ] = useLocalState(context, 'SelectedWho', YourWhos);
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const WhoToView = SearchTerm ? AllWhos[0] : SelectedWho;
  const WhyIsItEmpty = "Nobody's home!";

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
                <WhoSearchBar />
              )}/>
          </Stack.Item>
          <Stack.Item grow={1} basis={1}>
            <Section
              fill
              width="100%"
              scrollable>
              <Flex direction="row">
                <Flex.Item shrink={0}>
                  <WhoWhos />
                </Flex.Item>
                <Flex.Item grow={1} basis={0}>
                  <WhoBingus />
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

// The search bar at the top of the window.
// Its a search bar! You can look up anything, so long as its the name
// of a boi. or dragon pussy
const WhoSearchBar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    DP,
  } = data;
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');
  const FillerText = DP ? "Dragon Pussy" : "Find-A-Who 0.1b (tm)";

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
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');

  const [
    SelectedWho,
    setSelectedWho,
  ] = useLocalState(context, 'SelectedWho', YourWhos);

  if(SearchTerm.length > 0) {
    setSelectedWho(YourWhos);
  }
  setSearchTerm(props);
};

// The big holder of the categories! Its a long column of tabs that
// you can click on to select a category. The categories are defined
// in AllWhos, and the selected category is stored in the local state.
// We'll add on one additional tab at the end, not clickable, that
// will be the tally for all the boi points you've spent and have left!
const WhoWhoList = (props, context) => {
  const { act, data } = useBackend(context);
  const AllerWhos = SearchFilterize(null, context);
  const AllestWhos = [YourWhos].concat(AllerWhos); // surgery

  return (
    <Box
      p="0.5rem"
      mr="0.5rem"
      width="fit-content" // v i miss u 2F2F, glad Floormaster's doing okay
      backgroundColor="#2f2f2f">
      {AllestWhos.map(category => (
        <WhoTab Who={category} key={category} />
      ))}
    </Box>
  );
}; // not that big of a proc actually

// / One of the tabs in the category list. Its a tab! It has a name!
const WhoTab = (props, context) => {
  const { act, data } = useBackend(context);
  const Who = props.Who || "Oh no";

  const WhoDummy = Who.WhoIsDummy || false;
  const WhoName = !WhoDummy && Who.WhoCkey;

  const [
    SelectedWho,
    setSelectedWho,
  ] = useLocalState(context, 'SelectedWho', YourWhos);

  return (
    <Button
      key={WhoName}
      fluid
      px="0.5em"
      py="0.25em"
      selected={SelectedWho === WhoName}
      onClick={() =>
      { setSelectedWho(WhoName);
        setSearchTerm('');
      }}>
      <Box
        inline
        textAlign={'left'}>
        {WhoName}
      </Box>
    </Button>
  );
};

// Our currently selected boi, who we will be viewing in the right section.
// As an admeme, we can edit their name, role, where, and pose, and we can
// also ban them from editing their own name, role, where, and pose.
// We can also ban them from the server, and we can view their notes.
// But not from this system =3
const WhoBingus = (props, context) => {
  const { act, data } = useBackend(context);
  const [
    SelectedWho,
    setSelectedWho,
  ] = useLocalState(context, 'SelectedWho', YourWhos);
  if(SelectedWho.WhoIsDummy) {
    return (
      <NoticeBox active>
        "Select a boi to view their info!"
      </NoticeBox>
    );
  }

  // our selected Who, but with WhoCkey removed
  const Who = Object.assign({}, SelectedWho);
  delete Who.WhoCkey;

  return (
    <Section
      fill
      title={SelectedWho.WhoCkey}
      buttons={(
        <Button
          icon="times"
          onClick={() => {
            setSelectedWho(YourWhos);
            setSearchTerm('');
          }} />
      )}>
        <LabeledList>
          {
            Object.keys(Who).map(WhoEntry => (
              <Fragment>
                <LabeledList.Item
                  key={WhoEntry}
                  label={WhoEntry} >
                    {Who[WhoEntry].RealVal}
                </LabeledList.Item>
                <LabeledList.Item
                  key={WhoEntry}
                  label={"Custom " + WhoEntry} >
                  <Flex direction="row">
                    <Flex.Item grow={1} basis={0}>
                      <Button.Input
                        fluid
                        fill
                        content = {Who[WhoEntry].CustVal}
                        icon="pencil-alt"
                        defaultValue=""
                        currentValue={Who[WhoEntry].CustVal}
                        onCommit={() => {
                          act('SetValue', {
                            Who: SelectedWho.WhoCkey,
                            What: WhoEntry,
                            Value: Who[WhoEntry].CustVal,
                          });
                        }} />
                    </Flex.Item>
                    <Flex.Item shrink={1}>
                      <Button
                        icon="times"
                        onClick={() => {
                          act('ClearValue', {
                            Who: SelectedWho.WhoCkey,
                            What: WhoEntry,
                          });
                        }} />
                    </Flex.Item>
                  </Flex>
                </LabeledList.Item>
                <LabeledList.Item
                  key={WhoEntry}
                  label={"Banned from " + WhoEntry} >
                  <Button.Confirm
                    fluid
                    content={Who[WhoEntry].IsBanned ? "Unban" : "Ban"}
                    icon={Who[WhoEntry].IsBanned ? "smile-beam" : "frown"}
                    onClick={() => {
                      act('ToggleBan', {
                        Who: SelectedWho.WhoCkey,
                        What: WhoEntry,
                      });
                    }} />
                </LabeledList.Item>
                <LabeledList.Divider />
              </Fragment>
            ))
          }
        </LabeledList>
    </Section>
  );
};

// / A helper function for WhoTabs to get an array of boi objects
// / that are in a given category. It takes a category name, and an array
// / of boi objects, and returns an array of boi objects.
const SearchFilterize = (props, context) => {
  const { data } = useBackend(context);
  const AllWhos = data.AllWhos || [];
  const [
    SearchTerm,
    setSearchTerm,
  ] = useLocalState(context, 'SearchTerm', '');

  // searches through AllWhos and returns anyone whose ckey, name, role, where, or pose matches the search term
  if (SearchTerm.length > 0) {
    return AllWhos.filter(Who => {
      return Who.WhoCkey.toLowerCase().includes(SearchTerm.toLowerCase())
        || Who.WhoName.toLowerCase().includes(SearchTerm.toLowerCase())
        || Who.WhoRole.toLowerCase().includes(SearchTerm.toLowerCase())
        || Who.WhoWhere.toLowerCase().includes(SearchTerm.toLowerCase())
        || Who.WhoPose.toLowerCase().includes(SearchTerm.toLowerCase());
    });
  }
 return AllWhos; // return em all
};










