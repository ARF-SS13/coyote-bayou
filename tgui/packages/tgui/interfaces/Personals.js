/* eslint-disable max-len */
import { map, sortBy } from 'common/collections';
import { useBackend, useLocalState } from "../backend";
import { Button, LabeledList, Section, ProgressBar, Flex, Stack, Icon, Fragment, Box, Table, Tooltip } from '../components';
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
            <PersonalControls />
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

const PersonalControls = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    cached,
    user_data,
  } = data;
  const {
    name,
    online,
    species,
    flavor_text,
    ooc_text,
    personal_ad,
    job,
    adventure_role,
    is_healer,
    lfg,
    pvp_pref,
    listing_kind,
    approach_pref,
    rp_i_am_a,
    rp_looking_for,
    rp_length,
    rp_preferences,
    rp_notes,
    erp_i_am_a,
    erp_looking_for,
    erp_length,
    erp_types,
    position,
    visibility,
  } = user_data;
  const {
    vis_master
    vis_name
    vis_species
    vis_flavor_text
    vis_ooc_text
    vis_personal_ad
    vis_job
    vis_adventure_role
    vis_is_healer
    vis_lfg
    vis_pvp_pref
    vis_rp_i_am_a
    vis_rp_looking_for
    vis_rp_length
    vis_rp_preferences
    vis_rp_notes
    vis_erp_i_am_a
    vis_erp_looking_for
    vis_erp_length
    vis_erp_types
    vis_position
  } = visibility;

  return (
    <Section
      fluid
      title="Personal Controls">






