import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Icon, LabeledList, Section, Table, Stack } from '../components';
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
    personalVisibility,
    personalTag,
    personalErpTag,
    prefsOnly,
    personalAdvert,
    personalFlist,
  } = data;
  const [overlay, setOverlay] = useLocalState(context, 'overlay', null);

  const [overwritePrefs, setOverwritePrefs] = useLocalState(context, 'overwritePrefs', prefsOnly);

  return (
    <Window width={860} height={480} resizeable>
      <Window.Content scrollable>
        {(overlay && <ViewCharacter />) || (
          <Fragment>
            <Section
              title="Controls"
              buttons={
                <Fragment>
                  <Box color="label" inline>
                    Save to current preferences slot:&nbsp;
                  </Box>
                  <Button
                    icon={overwritePrefs ? 'toggle-on' : 'toggle-off'}
                    selected={overwritePrefs}
                    content={overwritePrefs ? 'On' : 'Off'}
                    onClick={() => prefsOnly ? act('noMind', { overwrite_prefs: overwritePrefs }) : setOverwritePrefs(!overwritePrefs)}
                  />
                </Fragment>
              }>
              <Box>
                <Stack fill> {/* option buttons, but compacter */}
                  <Stack.Item shrink>
                    Visibility:
                  </Stack.Item>
                  <Stack.Item grow>
                    <Button
                      icon={personalVisibility ? "toggle-on" : "toggle-off"}
                      selected={personalVisibility}
                      onClick={() => act('setVisible', { overwrite_prefs: overwritePrefs })}
                    />
                  </Stack.Item>
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
            <CharacterDirectoryList />
          </Fragment>
        )}
      </Window.Content>
    </Window>
  );
};

const ViewCharacter = (props, context) => {
  const [overlay, setOverlay] = useLocalState(context, 'overlay', null);

  return (
    <Section
      title={overlay.name}
      buttons={<Button icon="arrow-left" content="Back" onClick={() => setOverlay(null)} />}>
      <Section level={2} title="Gender">
        <Box>{overlay.gender}</Box>
      </Section>
      <Section level={2} title="Species">
        <Box>{overlay.species}</Box>
      </Section>
      <Section level={2} title="Vore?">
        <Box>{overlay.tag}</Box>
      </Section>
      <Section level={2} title="ERP Preference">
        <Box p={1} backgroundColor={erpTagColor[overlay.erptag]}>
          {overlay.erptag}
        </Box>
      </Section>
      <Section level={2} title="Who they like to kiss">
        <Box>{overlay.whokisser}</Box>
      </Section>
      <Section level={2} title="F-List Link">
        <Box>{overlay.flist_link}</Box>
      </Section>
      <Section level={2} title="Character Ad">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.character_ad || 'Unset.'}
        </Box>
      </Section>
      <Section level={2} title="OOC Notes">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.ooc_notes || 'Unset.'}
        </Box>
      </Section>
      <Section level={2} title="Flavor Text">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.flavor_text || 'Unset.'}
        </Box>
      </Section>
    </Section>
  );
};

const CharacterDirectoryList = (props, context) => {
  const { act, data } = useBackend(context);

  const { directory, canOrbit } = data;

  const [sortId, _setSortId] = useLocalState(context, 'sortId', 'name');
  const [sortOrder, _setSortOrder] = useLocalState(context, 'sortOrder', 'name');
  const [overlay, setOverlay] = useLocalState(context, 'overlay', null);

  return (
    <Section title="Directory" buttons={<Button icon="sync" content="Refresh" onClick={() => act('refresh')} />}>
      <Table>
        <Table.Row bold>
          <SortButton id="name">Name</SortButton>
          <SortButton id="gender">Gender</SortButton>
          <SortButton id="species">Species</SortButton>
          <SortButton id="whokisser">Preference</SortButton>
          <SortButton id="erptag">Position</SortButton>
          <SortButton id="tag">Vore</SortButton>
          <Table.Cell collapsing textAlign="right">
            Advert
          </Table.Cell>
          <Table.Cell collapsing textAlign="right">
            F-List
          </Table.Cell>
        </Table.Row>
        {directory
          .sort((a, b) => {
            const i = sortOrder ? 1 : -1;
            return a[sortId].localeCompare(b[sortId]) * i;
          })
          .map((character, i) => (
            <Table.Row key={i} backgroundColor={erpTagColor[character.erptag]}>
              <Table.Cell p={1}>
                {canOrbit ? <Button color={erpTagColor[character.erptag]} icon="ghost" tooltip="Orbit" content={character.name} onClick={() => act("orbit", { ref: character.ref })} /> : character.name}
              </Table.Cell>

              <Table.Cell>{character.gender}</Table.Cell>
              <Table.Cell>{character.species}</Table.Cell>
              <Table.Cell>{character.whokisser}</Table.Cell>
              <Table.Cell>{character.erptag}</Table.Cell>
              <Table.Cell>{character.tag}</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Button
                  onClick={() => setOverlay(character)}
                  color="transparent"
                  icon="sticky-note"
                  mr={1}
                  content="View"
                />
              </Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Button
                  onClick={() => act("view_flist", { ref: character.ref })}
                  color="transparent"
                  icon="linkify"
                  disabled={!character.flist_link}
                  mr={1}
                  content="Link"
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
    <Table.Cell collapsing>
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
