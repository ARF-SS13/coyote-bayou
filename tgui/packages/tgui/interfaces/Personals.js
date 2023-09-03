/* eslint-disable max-len */
import { map } from 'common/collections';
import { useBackend } from "../backend";
import { Button, Section, Flex, Stack, Icon, Fragment, Box, Table, Tabs, Tooltip, Collapsible } from '../components';
import { Window } from "../layouts";

export const Personals = (props, context) => {
  return (
    <Window
      width={1024}
      height={768}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <PersonalControlHolder />
          </Stack.Item>
          {/* <Stack.Item grow>
            <PersonalContent />
          </Stack.Item> */}
        </Stack>
      </Window.Content>
    </Window>
  );
};

// / The control panel holder, which holds the control panels of its children
// / The top has tabs that you can click to change which control panel is
// / displayed. doesnt use localstate cus i have self respect and i dont
// / know how to use it. change it if it bothers you =3
const PersonalControlHolder = (props, context) => {
  const { act, data } = useBackend(context);
  const { UserData } = data || [];
  const { CurrentTab, name } = UserData || [];
  const hi = "Welcome, " + user_data.name;
  const { ToolTips } = data || [];
  const ReadMe = ToolTips.readme;

  return (
    <Section
      fluid
      title={hi}
      width="100%"
      height="100%"
      overflowY="auto"
      buttons={(
        <Button
          icon="question"
          tooltip={ReadMe}
          onClick={() => act('help')}
        />
      )}>
      <Tabs>
        <Tabs.Tab
          selected={CurrentTab === 'rp'}
          onClick={() => act('SetTab', {
            Player: { name },
            Entry: 'rp',
          })}>
          Roleplay
        </Tabs.Tab>
        <Tabs.Tab
          selected={CurrentTab === 'adv'}
          onClick={() => act('SetTab', {
            Player: { name },
            Entry: 'adv',
          })}>
          Adventure
        </Tabs.Tab>
        <Tabs.Tab
          selected={CurrentTab === 'erp'}
          onClick={() => act('SetTab', {
            Player: { name },
            Entry: 'erp',
          })}>
          ERP
        </Tabs.Tab>
        <Tabs.Tab
          selected={CurrentTab === 'vis'}
          onClick={() => act('SetTab', {
            Player: { name },
            Entry: 'vis',
          })}>
          Visibility
        </Tabs.Tab>
      </Tabs>
      {
        tabIndex === 'rp' && (<PersonalControlPanel SettingIndex="RP" />)
        || tabIndex === 'adv' && (<PersonalControlPanel SettingIndex="Adventure" />)
        || tabIndex === 'erp' && (<PersonalControlPanel SettingIndex="ERP" />)
        || tabIndex === 'vis' && (<PersonalControlPanelVisibility />)
        || tabIndex === 'hide' && (<PersonalContent />)
      }
    </Section>
  );
};

const PersonalControlPanel = (SettingIndex, context) => {
  const { act, data } = useBackend(context);
  const { EntryKinds } = data || [];
  const { EntryList } = EntryKinds[SettingIndex] || [];

  return (
    <Section
      title={SettingIndex + " Settings"} >
      <Flex>
        {map(EntryList, (entry, index) => (
          <Flex.Item
            grow={1}
            key={index}
            width="33%">
            <PersonalControl EntryIndex={entry} />
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};

// / A control panel entry box thing that contains the label and the
// / data. The header is the label, which has a cool tooltip,
// / and the body is the data, which is a text field that can be
const PersonalControl = (EntryIndex, context) => {
  const { act, data } = useBackend(context);
  // / The data for the player is stored in the UserData array
  // / The index of the array is the same as the index of the
  // / entry in the EntryKinds array
  const {
    UserData,
    EntryTooltips,
    EntryLabels,
  } = data || [];
  const { EntryVisible } = UserData.visibility[EntryIndex] || [];
  const { PlayerName } = UserData['name'] || [];
  const { EntryData } = UserData[EntryIndex] || [];
  const { EntryLabel } = EntryLabels[EntryIndex] || [];
  const { EntryTooltip } = EntryTooltips[EntryIndex] || [];

  return (
    <Section
      title={EntryLabel}
      buttons={(
        <Fragment>
          <Tooltip
            content={EntryTooltip}>
            <Icon
              name="question"
              color="white"
              ml={1} />
          </Tooltip>
          <Button
            tooltip="Show/Hide this entry from others?"
            onClick={() => act('ToggleVisibility', {
              Player: { PlayerName },
              Entry: EntryIndex,
            })} >
            <Icon
              name={EntryVisible ? 'eye' : 'eye-slash'}
              color="white"
              ml={1} />
          </Button>
        </Fragment>
      )}>
      <Button
        tooltip="Change?"
        backgroundColor="transparent"
        fluid
        onClick={() => act('ChangeEntry', {
          Player: { PlayerName },
          Entry: EntryIndex,
        })}>
        {EntryData}
      </Button>
    </Section>
  );
};

// / This one is different from the others because it's a big ol' grid
// / of buttons that you can click to change your visibility settings
// / Lets you hide certain things from other people
const PersonalControlPanelVisibility = (props, context) => {
  const { act, data } = useBackend(context);
  const { VisibilityData } = data || [];
  const { VisibilityList } = VisibilityData || [];
  const EntryWidth = "25%";

  return (
    <Section
      title="Visibility Settings"
      buttons={(
        <Tooltip
          content="Lets you show/hide individual parts from other players">
          <Icon
            name="question"
            color="white"
            ml={1} />
        </Tooltip>
      )}>
      <Flex>
        <Flex.Item
          grow={1}
          width={EntryWidth}>
          <Tooltip
            content="This is the master visibility button. If unchecked, you will be hidden from everyone.">
            <PersonalControlVisibility EntryIndex="Master" />
          </Tooltip>
        </Flex.Item>
        {map(VisibilityList, (entry, index) => ( // ^ This is the master visibility button, its special
          <Flex.Item
            grow={1}
            key={index}
            width={EntryWidth}>
            <PersonalControlVisibility EntryIndex={index} />
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};

// / This is the actual button that you click to change your visibility
// / settings. It's a button that has a tooltip, a checkbox, and a label
const PersonalControlVisibility = (EntryIndex, context) => {
  const { act, data } = useBackend(context);
  const { UserData } = data || [];
  const { PlayerName } = UserData.name || [];
  const { VisibilityData } = data || [];
  const { VisibilityList } = VisibilityData || [];
  const { EntryLabel } = VisibilityList[EntryIndex] || [];

  return (
    <Button
      tooltip={EntryLabel}
      fluid
      onClick={() => act('ChangeVisibility', {
        Player: { PlayerName },
        Entry2Change: EntryIndex,
      })}>
      {EntryLabel}
    </Button>
  );
};

// / and now, the big bad muffkin personals box
// / this is the box that displays the actual personals
// / It has sort buttons at the top
// / Its got a scrollable list of personals
// / Its got realistic dragon pussy
// / Lets do this
const PersonalContent = (props, context) => {
  const { act, data } = useBackend(context);
  const { PersonalsHelp } = data || "Oops! you're on your own!";
  // jk no dragon pussy yet
  // and this is a holder for the personals
  // / holders all the way down
  return (
    <Section
      title="Personals"
      overflowY="scroll"
      height="100%"
      fluid
      buttons={(
        <Tooltip tooltip={PersonalsHelp}>
          <Icon
            name="question"
            color="white"
            ml={1} />
        </Tooltip>
      )}>
      <Stack fill vertical>
        <Stack.Item>
          <PersonalSortButtons />
        </Stack.Item>
        <Stack.Item grow>
          <PersonalList />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

// / This is the box that holds the sort buttons
// / It has a button for each sort type, like...
// / "Sort by name", and "Sort by... something else"
// / I dont know what else to say about it
const PersonalSortButtons = (props, context) => {
  const { act, data } = useBackend(context);
  const { SortButtons } = data || [];

  return (
    <Flex>
      {map(SortButtons, (entry, index) => (
        <Flex.Item
          grow={1}
          key={index}>
          <PersonalSortButton EntryIndex={entry} />
        </Flex.Item>
      ))}
    </Flex>
  );
};

// / its a button that sorts the personals
// / It has a little arrow button to show which way its sorting
const PersonalSortButton = (EntryIndex, context) => {
  const { act, data } = useBackend(context);
  const { UserData } = data || [];
  const { PlayerName } = UserData.name || [];
  const { sortby, sortdir } = data.UserData || []; // localstate is stored in the balls
  const HiLiteBG = sortby === EntryIndex ? 'blue' : 'transparent';

  return (
    <Button
      fluid
      backgroundColor={HiLiteBG}
      onClick={() => act('SortBy', {
        Player: { PlayerName },
        Entry: EntryIndex,
      })}>
      {EntryIndex}
      <Icon
        name={sortdir === 'asc' ? 'arrow-up' : 'arrow-down'}
        color="white"
        ml={1} />
    </Button>
  );
};

// / This is the actual personals list listing list thing
// / It has a list of personals, and you can click on them
// / to view more about them
// / While collapsed... ah we'll get to that later
// / Here be the dragon pussy, I promise
const PersonalList = (props, context) => {
  const { act, data } = useBackend(context);
  const { UserData, IsAdmin } = data || [];
  const { sortby, sortdir } = UserData || []; // localstate is stored in the balls
  const { cached } = data || [];
  // / If the player reading is an admin, just show them everything
  // / Otherwise, check if that cached entry's master visibility is true
  // / If it is, show it. If not, remove it
  const { CachedVisPrefilter } = cached.filter(entry => {
    if (IsAdmin) {
      return entry;
    } else {
      return entry.visibility.master === true;
    }
  }) || [];
  // / yeah theres that dragon pussy in all its glory
  const { CacheSorted } = CachedVisPrefilter.sort((a, b) => {
    const descA = a[sortby].toLowerCase();
    const descB = b[sortby].toLowerCase();
    switch (sortdir) {
      case 'asc':
        if (descA < descB) {
          return -1;
        }
        if (descA > descB) {
          return 1;
        }
        return 0;
      case 'desc':
        if (descA > descB) {
          return -1;
        }
        if (descA < descB) {
          return 1;
        }
        return 0;
      default:
        return 0;
    }
  }) || []; // jk no dragon pussy yet

  return (
    <Stack fill vertical>
      {map(cached, (entry, index) => (
        <Stack.Item
          key={index}>
          <PersonalEntryHolder Personal={cached[index]} />
        </Stack.Item>
      ))}
    </Stack>
  );
};

// / This is the actual entry in the personals list
// / It has a header with sort-related stuff like name and species
// / The body has a few collapsed sections, like "RP", "Adventure", and "ERP"
// / The footer has a button to view the full profile in all its glory
// / I promise, the dragon pussy is coming
const PersonalEntryHolder = (Personal, context) => {
  const { act, data } = useBackend(context);
  const { visibility } = Personal || [];
  const { UserData } = data || [];
  const { IsAdmin } = UserData || [];
  // / This is a huge array
  // / we all know what mrs puff says about huge arrays
  // / they fuckin suck
  const CachedVisCalc = <PersonalVisparsed
    VisSettings={visibility}
    PlayerData={Personal}
    IsAdmin={IsAdmin} /> || [];

  return (
    <Box
      width="100%"
      height="fit-content"
      fluid>

      <Stack fill vertical>
        <Stack.Item>
          <PersonalHeader FilteredPlayerData={CachedVisCalc} />
        </Stack.Item>
        <Stack.Item>
          <PersonalDatapane
            FilteredPlayerData={CachedVisCalc}
            DataKind="RP" />
        </Stack.Item>
        <Stack.Item>
          <PersonalDatapane
            FilteredPlayerData={CachedVisCalc}
            DataKind="Adventure" />
        </Stack.Item>
        <Stack.Item>
          <PersonalDatapane
            FilteredPlayerData={CachedVisCalc}
            DataKind="ERP" />
        </Stack.Item>
      </Stack>
    </Box>
  );
};

// / This is the online dot that shows if the player is online or not
// / It's a little dot that's green if they're online, red if they're not
// / Think of it as a dragon cl1t (gpt doesnt like that word)
const PersonalOnlineDot = (FilteredPlayerData, context) => {
  const { act, data } = useBackend(context);
  const { ToolTips } = data || [];
  return (
    <Tooltip
      tooltip={ToolTips.online}>
      <Icon
        name={FilteredPlayerData.online ? 'circle' : 'circle-o'}
        color={FilteredPlayerData.online ? 'green' : 'red'}
        mr={1} />
    </Tooltip>
  ); // dragon cl1t bang
};

// / This is the header of the personals entry
// / It has the name, species, and job of the player
// / For real this time! This is part 1 of the dragon pussy
// / The dragon mons pubis
const PersonalHeader = (FilteredPlayerData, context) => {
  const { act, data } = useBackend(context);
  const { UserData } = data || [];
  const { PlayerName } = UserData.name || [];
  const HealerGlunt = FilteredPlayerData.adventure_is_healer
    ? (<Icon
        name="heart"
        color="green"
        ml={1} />)
    : (<Icon
        name="heart-o"
        color="red"
        ml={1} />);
  let BillTheCatBikiniInspector = <PersonalOnlineDot FilteredPlayerData={FilteredPlayerData} />
    + Filtered.name
    + " the "
    + Filtered.species
    + " "
    + Filtered.job
    + " "
    + HealerGlunt
    + " "
    + !!FilteredPlayerData.adventure_lfg && "[LFG]";

  return (
    <Section
      title={BillTheCatBikiniInspector}
      buttons={(
        <Button
          icon="eye"
          tooltip="View full profile"
          onClick={() => act('ViewProfile', {
            Player: PlayerName,
            Viewed: FilteredPlayerData.name,
          })} />
      )} />
  );
};

// / eslint is gonna have a fu(k)in fit over all this
// / wonder if I can disable it

// / This is a functional section of the personals entry
// / It starts life collapsed, but you can click on it to expand it
// / It has a shitload of RP, Adventure, or ERP stuff in it
// / This is parts 2 thru 4 of the dragon pussy
// / The dragon lab1a maj0ra, the dragon ov4ries, and the dragon ut3rus
const PersonalDatapane = (FilteredPlayerData, DataKind, context) => {
  const { act, data } = useBackend(context);
  const { EntryKinds } = data || [];
  const { EntryList } = EntryKinds[DataKind] || [];
  const { SortedEntryList } = EntryList.sort((a, b) => {
    const descA = a.toLowerCase();
    const descB = b.toLowerCase();
    if (descA < descB) {
      return -1;
    }
    if (descA > descB) {
      return 1;
    }
    return 0;
  }) || [];
  const { EntryLabels } = data || [];
  const { EntryTooltips } = data || [];

  return (
    <Collapsible
      title="Roleplay"
      width="100%">
      <Section
        title="RP Notes">
        <Table width="100%">
          {SortedEntryList.map((entry, index) => (
            <Table.Row
              key={index}>
              <Table.Cell
                width="25%">
                <Tooltip
                  content={EntryTooltips[entry]}>
                  {EntryLabels[entry]}
                </Tooltip>
              </Table.Cell>
              <Table.Cell
                width="75%">
                {FilteredPlayerData[entry]}
              </Table.Cell>
            </Table.Row>
          ))}
        </Table>
      </Section>
    </Collapsible>
  );
};

// / Helper proc that takes in a visibility list and a player data
// / and spits out a huge array of parsed player data
// / This is the part that actually filters out the inner bits of personals
// / Like dragon pussy (dont filter that out)
const PersonalVisparsed = (VisSettings, PlayerData, IsAdmin, context) => {
  const { act, data } = useBackend(context);
  const { UserData } = data || [];
  const { UserVis } = UserData.visibility || [];
  let FrickhugeArray = [
    online = PlayerData.online,
    species = PlayerData.species,
    flavor_text = PlayerData.flavor_text,
    ooc_text = PlayerData.ooc_text,
    adventure_notes = PlayerData.adventure_notes,
    adventure_i_am_a = PlayerData.adventure_i_am_a,
    adventure_looking_for = PlayerData.adventure_looking_for,
    adventure_in_it_for = PlayerData.adventure_in_it_for,
    adventure_listing_kind = PlayerData.adventure_listing_kind,
    adventure_is_healer = PlayerData.adventure_is_healer,
    adventure_lfg = PlayerData.adventure_lfg,
    adventure_pvp_pref = PlayerData.adventure_pvp_pref,
    rp_notes = PlayerData.rp_notes,
    rp_job = PlayerData.rp_job,
    rp_i_am_a = PlayerData.rp_i_am_a,
    rp_looking_for = PlayerData.rp_looking_for,
    rp_listing_kind = PlayerData.rp_listing_kind,
    rp_approach_pref = PlayerData.rp_approach_pref,
    rp_length = PlayerData.rp_length,
    rp_preferences = PlayerData.rp_preferences,
    erp_notes = PlayerData.erp_notes,
    erp_i_am_a = PlayerData.erp_i_am_a,
    erp_looking_for = PlayerData.erp_looking_for,
    erp_listing_kind = PlayerData.erp_listing_kind,
    erp_approach_pref = PlayerData.erp_approach_pref,
    erp_length = PlayerData.erp_length,
    erp_post_length = PlayerData.erp_post_length,
    erp_sexuality = PlayerData.erp_sexuality,
    erp_sex = PlayerData.erp_sex,
    erp_gender = PlayerData.erp_gender,
    erp_position = PlayerData.erp_position,
    erp_vore = PlayerData.erp_vore,
  ];

  // / If the player reading is an admin, just show them everything
  if (IsAdmin) {
    return FrickhugeArray; // Theres that dragon pussy
  } else {
    // / Otherwise, go through every entry in PlayerData and check if it is visible
    // / If it is, leave it be. If not, replace that entry's value with "~unknown~"
    FrickhugeArray.forEach((entry, index) => {
      if (VisSettings[index] === true && UserVis[index] === true) {
        return entry;
      } else {
        FrickhugeArray[index] = "~unknown~";
      }
    });
    return FrickhugeArray; // Theres that dragon pussy
  }
};

