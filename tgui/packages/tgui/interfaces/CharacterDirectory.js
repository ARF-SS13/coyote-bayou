/* eslint-disable */
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import {
  Box,
  Button,
  Icon,
  LabeledList,
  Section,
  Table,
  Flex,
  Tabs,
  ToggleBox,
  Stack,
  Tooltip} from '../components';
import { Window } from '../layouts';

const erpTagColor = {
  'Unset': 'label',
  'Top': 'red',
  'Bottom': 'blue',
  'Switch': 'purple',
  'No ERP': 'black',
};

export const CharacterDirectory = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    personalName,
    personalVisibility,
    personalTag,
    personalErpTag,
    prefsOnly,
    personalAdvert,
    personalFlist,
    personalDMs,
  } = data;

  const [
    SelectedTab,
    setSelectedTab,
  ] = useLocalState(context, 'SelectedTab', 1);

  return (
    <Window
      width={1280}
      height={600}
      theme="ntos"
      title="Coyote Bayou Yellow Pages"
      resizable>
      <Window.Content
        style={{
          "background-image": "url('../../assets/bg-hornysex.png')",
          "background-size": "fill",
        }}>
        <Stack fill vertical>
          <Stack.Item>
            <Section
              title={`Welcome, ${personalName}!`}
              buttons={
                <VisibilityButton />
              } />
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
                Directory
              </Tabs.Tab>
              <Tabs.Tab
                selected={SelectedTab === 2}
                onClick={() => {
                  setSelectedTab(2);
                  act('JustUpdate');
                }}>
                Options
              </Tabs.Tab>
              {/* <Tabs.Tab
                textAlign="center"
                selected={SelectedTab === 3}
                onClick={() => {
                  setSelectedTab(3);
                  act('JustUpdate');
                }}>
                <Icon
                  name="question-circle"
                  color="green"
                  size={1.5} />
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

const VisibilityButton = (props, context) => {
  const { act, data } = useBackend(context);
  const { personalVisibility } = data;

  return (
    <Button
      icon={personalVisibility ? 'toggle-on' : 'toggle-off'}
      selected={personalVisibility}
      onClick={() => act('setVisible')}>
      {personalVisibility ? 'Visible' : 'Invisible'}
    </Button>
  );
}

// / The main window! either your characters or the available characters
const MainWindow = (props, context) => { // main screen turn on
  const { act, data } = useBackend(context);

  const [
    SelectedTab,
    setSelectedTab,
  ] = useLocalState(context, 'SelectedTab', 1);


  return (
    <>
      {SelectedTab === 1 && (
        <CharacterDirectoryList />
      )}
      {SelectedTab === 2 && (
        <SettingsControl />
      )}
      {SelectedTab === 3 && (
        <ReadMe />
      )}
    </>
  );
};

const SettingsControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    personalName,
    personalVisibility,
    personalTag,
    personalErpTag,
    prefsOnly,
    personalAdvert,
    personalFlist,
    personalDMs,
  } = data;

  const [overwritePrefs, setOverwritePrefs] = useLocalState(context, 'overwritePrefs', prefsOnly);
  return (
    <Section
      title="Controls"
      buttons={
        <Fragment>
          {/* <Box color="label" inline>
            Save to current preferences slot:&nbsp;
          </Box>
          <Button
            icon={overwritePrefs ? 'toggle-on' : 'toggle-off'}
            selected={overwritePrefs}
            content={overwritePrefs ? 'On' : 'Off'}
            onClick={() => prefsOnly ? act('noMind', { overwrite_prefs: overwritePrefs }) : setOverwritePrefs(!overwritePrefs)}
          /> */}
        </Fragment>
      }>
      <Box>
        <Stack fill> {/* option buttons, but compacter */}
          {/* <Stack.Item shrink>
            Visibility:
          </Stack.Item>
          <Stack.Item grow>
            <Button
              icon={personalVisibility ? "toggle-on" : "toggle-off"}
              selected={personalVisibility}
              onClick={() => act('setVisible', { overwrite_prefs: overwritePrefs })}
            />
          </Stack.Item> */}
          {/* <Stack.Item shrink>
            Open For DMs:
          </Stack.Item>
          <Stack.Item grow>
            <Button
              icon={personalDMs ? "toggle-on" : "toggle-off"}
              selected={personalDMs}
              onClick={() => act('setDMs', { overwrite_prefs: overwritePrefs })}
            />
          </Stack.Item> */}
          <Stack.Item shrink>
            Vore Tag:
          </Stack.Item>
          <Stack.Item grow>
            <Button
              icon={personalTag === "Unset"? "toggle-off" : "toggle-on"}
              selected={personalTag === "Unset"? false : true}
              content={personalTag}
              onClick={() => act('setTag', { overwrite_prefs: overwritePrefs })}
            />
          </Stack.Item>
          <Stack.Item shrink>
            ERP Tag:
          </Stack.Item>
          <Stack.Item grow>
            <Button
              icon={personalErpTag === "Unset"? "toggle-off" : "toggle-on"}
              selected={personalErpTag === "Unset"? false : true}
              content={personalErpTag}
              onClick={() => act('setErpTag', { overwrite_prefs: overwritePrefs })}
            />
          </Stack.Item>
        </Stack>
      </Box>
      <LabeledList>
        <LabeledList.Item label="Advertisement">
          <Button
            icon="sticky-note"
            fluid
            content={personalAdvert}
            onClick={() => act('editAd', { overwrite_prefs: overwritePrefs })}
          />
        </LabeledList.Item>
        <LabeledList.Item label="F-List Link">
          <Button
            icon="linkify"
            fluid
            content={personalFlist}
            onClick={() => act('editFlist', { overwrite_prefs: overwritePrefs })}
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const ReadMe = (props, context) => {
  const { act, data } = useBackend(context);
  const { ReadmeText } = data;

  return (
    <Section title="Read Me">
      <Box dangerouslySetInnerHTML={{ __html: ReadmeText }} />
    </Section>
  );
};

const BottomToolbar = (props, context) => {
  const { act, data } = useBackend(context);
  const { personalLookingForFriends } = data;

  return (
    <Box>
      <Flex direction="column">
        <Flex.Item grow={1}>
          <Box />
        </Flex.Item>
        <Flex.Item>
          <Button
            icon={personalLookingForFriends ? "toggle-on" : "toggle-off"}
            selected={personalLookingForFriends}
            content={personalLookingForFriends ? "Looking for Friends" : "Not Looking for Friends"}
            onClick={() => act('setLookingForFriends')} />
        </Flex.Item>
      </Flex>
    </Box>
  );
};

const CharacterDirectoryList = (props, context) => {
  const { act, data } = useBackend(context);

  const { directory, canOrbit } = data;

  const [sortId, _setSortId] = useLocalState(context, 'sortId', 'name');
  const [sortOrder, _setSortOrder] = useLocalState(context, 'sortOrder', 'name');
  const [overlay, setOverlay] = useLocalState(context, 'overlay', null);

  return (
    <Section
      title="Directory"
      buttons={
        <Button
          icon="sync"
          content="Refresh"
          onClick={() => act('refresh')} />
        }>
      <Table collapsing>
        <Table.Row bold>
          <SortButton id="looking_for_friends">
            <Tooltip
              content="These people are looking to make new friends! Why not click a star and say hello?">
              LFF
            </Tooltip>
          </SortButton>
          <SortButton id="name">Name</SortButton>
          <SortButton id="gender">Gender</SortButton>
          <SortButton id="species">Species</SortButton>
          <SortButton id="whokisser">Orientation</SortButton>
          <SortButton id="erptag">Position</SortButton>
          <SortButton id="tag">Vore</SortButton>
          <Table.Cell collapsing textAlign="center">
            Examine
          </Table.Cell>
          <Table.Cell collapsing textAlign="center">
            F-List
          </Table.Cell>
          <Table.Cell collapsing textAlign="center">
            Message
          </Table.Cell>
        </Table.Row>
        {directory
          .sort((a, b) => {
            const i = sortOrder ? 1 : -1;
            const thea_string = a[sortId].toString()
            const theb_string = b[sortId].toString()
            return thea_string.localeCompare(theb_string) * i;
          })
          .map((character, i) => (
            <Table.Row
              key={i}
              backgroundColor={erpTagColor[character.erptag] || 'label'}
              style={{
                border: '1px solid #000',
                "border-radius": "30px",
              }}>
              <Table.Cell p={1} collapsing textAlign="center">
                {character.looking_for_friends ?
                  <Button
                    icon="star"
                    color="green"
                    // tooltip="This person is looking to make new friends! Why not click here and say hello?"
                    onClick={() => act("pager", { quid: character.quid })} />
                  : <Fragment />
                }
              </Table.Cell>
              <Table.Cell p={1} collapsing>
                {canOrbit
                  ? <Button
                    color={erpTagColor[character.erptag]}
                    icon="ghost"
                    // tooltip="Orbit"
                    onClick={() => act("orbit", { ref: character.ref })} />
                  : <Fragment />}
                  {` ${character.name}`}
              </Table.Cell>
              <Table.Cell>{character.gender}</Table.Cell>
              <Table.Cell>{character.species}</Table.Cell>
              <Table.Cell>{character.whokisser}</Table.Cell>
              <Table.Cell>{character.erptag}</Table.Cell>
              <Table.Cell>{character.tag}</Table.Cell>
              <Table.Cell collapsing textAlign="center">
                <Button
                  onClick={() => act("inspect", {
                    quid: character.quid,
                    my_quid: data.personalQuid,
                    name: character.name,
                    species: character.species,
                    ooc_notes: character.ooc_notes,
                    tag: character.tag,
                    erptag: character.erptag,
                    character_ad: character.character_ad,
                    flavor_text: character.flavor_text,
                    ref: character.ref,
                    gender: character.gender,
                    whokisser: character.whokisser,
                    flist: character.flist,
                    quid: character.quid,
                    dms_r_open: character.dms_r_open,
                    looking_for_friends: character.looking_for_friends,
                    profile_pic: character.profile_pic,
                  })} // OH BOY BINGUS INSPECTION DAY
                  icon="sticky-note"
                  mr={1}
                  content="View"
                />
              </Table.Cell>
              <Table.Cell collapsing textAlign="center">
                {character.flist ?
                  <Button
                    onClick={() => act("view_flist", { quid: character.quid })}
                    icon="link"
                    mr={1}
                    content="F-List" />
                  : <Fragment />
                }
              </Table.Cell>
              <Table.Cell collapsing textAlign="center">
                <Button
                  onClick={() => act("pager", { quid: character.quid })}
                  icon="envelope"
                  // tooltip="Send a message to this character!"
                  mr={1}
                />
              </Table.Cell>
            </Table.Row>
          ))}
      </Table>
    </Section>
  );
};

const SortButton = (props, context) => {
  const { act, data } = useBackend(context);

  const { id, children } = props;

  // Hey, same keys mean same data~
  const [sortId, setSortId] = useLocalState(context, 'sortId', 'name');
  const [sortOrder, setSortOrder] = useLocalState(context, 'sortOrder', 'name');

  return (
    <Table.Cell collapsing textAlign="center" width="1px">
      <Button
        width="100%"
        color={sortId !== id && 'transparent'}
        onClick={() => {
          if (sortId === id) {
            setSortOrder(!sortOrder);
          } else {
            setSortId(id);
            setSortOrder(true);
          }
        }}>
        {children}
        {sortId === id && <Icon name={sortOrder ? 'sort-up' : 'sort-down'} ml="0.25rem;" />}
      </Button>
    </Table.Cell>
  );
};
