/* eslint-disable max-len */
import { map, sortBy } from 'common/collections';
import { useBackend, useLocalState } from "../backend";
import { Button, LabeledList, Section, ProgressBar, Flex, Stack, Icon, Fragment, Box, Table, Tabs, Tooltip } from '../components';
import { Window } from "../layouts";
import { resolveAsset } from '../assets';
import { marked } from 'marked';
import { sanitizeText } from '../sanitize';

export const Personals = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    cached,
  } = data;

  return (
    <Window
      width={1024}
      height={768}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <PersonalHeader />
          </Stack.Item>
          <Stack.Item>
            <PersonalControlHolder />
          </Stack.Item>
          <Stack.Item grow>
            <PersonalContent />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const PersonalHeader = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    cached,
    user_data,
  } = data;
  const hi = "Welcome, " + user_data.name;

  return (
    <Section
      fluid
      title={hi}
      buttons={(
        <Button
          icon="question"
          tooltip="Help"
          onClick={() => act('help')} />
      )} />
  );
};

const PersonalControlHolder = (props, context) => {
  const { act, data } = useBackend(context);
  const [tabIndex, setTabIndex] = useLocalState(context, 'tabIndex', 'hide');

  return (
    <Box
      width="100%"
      height="fit-content"
      overflowY="auto">
      <Tabs>
        <Tabs.Tab
          selected={tabIndex === 'adv'}
          onClick={() => {
            if (tabIndex === 'adv') {
              setTabIndex('hide');
            } else {
              setTabIndex('adv')}
          }}>
          Adventure
        </Tabs.Tab>
        <Tabs.Tab
          selected={tabIndex === 'rp'}
          onClick={() => {
            if (tabIndex === 'rp') {
              setTabIndex('hide');
            } else {
              setTabIndex('rp')}
          }}>
          Roleplay
        </Tabs.Tab>
        <Tabs.Tab
          selected={tabIndex === 'erp'}
          onClick={() => {
            if (tabIndex === 'erp') {
              setTabIndex('hide');
            } else {
              setTabIndex('erp')}
          }}>
          ERP
        </Tabs.Tab>
        <Tabs.Tab
          selected={tabIndex === 'vis'}
          onClick={() => {
            if (tabIndex === 'vis') {
              setTabIndex('hide');
            } else {
              setTabIndex('vis')}
          }}>
          Visibility
        </Tabs.Tab>
      </Tabs>
      {tabIndex === 'rp' && (
        <PersonalControlPanelRoleplay />
      ) || tabIndex === 'adv' && (
        <PersonalControlPanelAdventure />
      ) || tabIndex === 'erp' && (
        <PersonalControlPanelERP />
      ) || tabIndex === 'vis' && (
        <PersonalControlPanelVisibility />
      ) || tabIndex === 'hide' && (
        <Box />
      )}
    </Box>
  );
};

const PersonalControlPanelAdventure = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    user_data,
  } = data;
  const {
    name,
    lfg,
    adventure_role,
    is_healer,
    adventure_in_it_for,
    pvp_pref,
  } = user_data;

  return (
    <Section
      title="Adventure Settings"
      buttons={(
        <Button
          icon="question"
          tooltip="Help"
          onClick={() => act('readme', {
            player: {name},
            entry: 'adventure_settings',
          })} />
      )}>
      <LabeledList>
        <LabeledList.Item
          label="Adventure Role"
          buttons={(
            <Button
              icon="question"
              tooltip="Help"
              onClick={() => act('readme', {
                player: {name},
                entry: 'adventure_role',
              })} />
          )}>
          <Button
            tooltip="Change?"
            backgroundColor='transparent'
            fluid
            onClick={() => act('request_input', {
              player: {name},
              entry: 'adventure_role',
            })}>
            {adventure_role}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item
          label="Healer?"
          buttons={(
            <Button
              icon="question"
              tooltip="Help"
              onClick={() => act('readme', {
                player: {name},
                entry: 'is_healer',
              })} />
          )}>
          <Button
            tooltip="Change?"
            width="fit-content"
            height="fit-content"
            icon={is_healer === 1 ? 'check' : 'times'}
            onClick={() => act('toggle_entry', {
              player: {name},
              entry: 'is_healer',
            })} />
        </LabeledList.Item>
        <LabeledList.Item
          label="Looking for Group?"
          buttons={(
            <Button
              icon="question"
              tooltip="Help"
              onClick={() => act('readme', {
                player: {name},
                entry: 'lfg',
              })} />
          )}>
          <Button
            tooltip="Change?"
            width="fit-content"
            height="fit-content"
            icon={lfg === 1 ? 'check' : 'times'}
            onClick={() => act('toggle_entry', {
              player: {name},
              entry: 'lfg',
            })} />
        </LabeledList.Item>
        <LabeledList.Item
          label="In it for..."
          buttons={(
            <Button
              icon="question"
              tooltip="Help"
              onClick={() => act('readme', {
                player: {name},
                entry: 'adventure_in_it_for',
              })} />
          )}>
          <Button
            tooltip="Change?"
            backgroundColor='transparent'
            fluid
            onClick={() => act('request_input', {
              player: {name},
              entry: 'adventure_in_it_for',
            })}>
            {adventure_in_it_for}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item
          label="PvP Preference"
          buttons={(
            <Button
              icon="question"
              tooltip="Help"
              onClick={() => act('readme', {
                player: {name},
                entry: 'pvp_pref',
              })} />
          )}>
          <Button
            tooltip="Change?"
            backgroundColor='transparent'
            fluid
            onClick={() => act('request_input', {
              player: {name},
              entry: 'pvp_pref',
            })}>
            {pvp_pref}
          </Button>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const PersonalControlPanelRoleplay = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    user_data,
  } = data;
  const {
    job,
    listing_kind,
    personal_ad,
    approach_pref,
    rp_i_am_a,
    rp_looking_for,
    rp_length,
    rp_preferences,
    rp_notes,
  } = user_data;

  return (
    <Section
      title="Roleplay Settings"
      buttons={(
        <Button
          icon="question"
          tooltip="Help"
          onClick={() => act('readme', {
            player: {name},
            entry: 'roleplay_settings',
          })} />
      )}>
      <LabeledList>
        <LabeledList.Item
          label="Job"
          buttons={(
            <Button
              icon="question"
              tooltip="Help"
              onClick={() => act('readme', {
                player: {name},
                entry: 'job',
              })} />
          )}>
          <Button
            tooltip="Change?"
            backgroundColor='transparent'
            fluid
            onClick={() => act('request_input', {
              player: {name},
              entry: 'job',
            })}>
            {job}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item
          label="Listing Kind"
          buttons={(
            <Button
              icon="question"
              tooltip="Help"
              onClick={() => act('readme', {
                player: {name},
                entry: 'listing_kind',
              })} />
          )}>
          <Button
            tooltip="Change?"
            backgroundColor='transparent'
            fluid
            onClick={() => act('request_input', {
              player: {name},
              entry: 'listing_kind',
            })}>
            {listing_kind}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item
          label="Personal Ad"
          buttons={(
            <Button
              icon="question"
              tooltip="Help"
              onClick={() => act('readme', {
                player: {name},
                entry: 'personal_ad',
              })} />
          )}>
          <Button
            tooltip="Change?"
            backgroundColor='transparent'
            fluid
            onClick={() => act('request_input', {
              player: {name},
              entry: 'personal_ad',
            })}>
            {personal_ad}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item
          label="Approach Preference"
          buttons={(
            <Button
              icon="question"
              tooltip="Help"
              onClick={() => act('readme', {
                player: {name},
                entry: 'approach_pref',
              })} />
          )}>
          <Button
            tooltip="Change?"
            backgroundColor='transparent'
            fluid
            onClick={() => act('request_input', {
              player: {name},
              entry: 'approach_pref',
            })}>
            {approach_pref}
          </Button>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};




const PersonalSettingInput = (Index, context) => {
  const { act, data } = useBackend(context);


const PersonalToolTip = (TipIndex, context) => {
  const { act, data } = useBackend(context);
  const {tooltips} = data || [];
  const {TipOut} = tooltips[TipIndex] || "Tip not available. Sorry! ^^;";

  return (
    <Tooltip
      content={TipOut}
      placement="bottom-start">
      <Icon
        name="question"
        color="label" />
    </Tooltip>
  );
};






