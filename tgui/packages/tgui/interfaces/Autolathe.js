/* eslint-disable max-len */
import { useBackend, useLocalState } from '../backend';
import { Button, LabeledList, Section, ProgressBar, Flex, Box, Table, Collapsible, Input, Dimmer, Icon, Stack } from '../components';
import { Window } from '../layouts';
import { capitalize } from "common/string";

const BGgradientStyle = {
  'border-radius': '0.25rem',
  'border': '1px solid #444466',
  'background-image': 'linear-gradient(#222244, #444466, #444466, #222244)',
};
const BGStyle = {
  'border-radius': '0.25rem',
  'border': '1px solid #444466',
  'background-image': 'linear-gradient(#222244, #222244)',
};
const BGGradientTopDownStyle = {
  'border-radius': '0.25rem',
  'border': '1px solid #444466',
  'background-image': 'linear-gradient(#222244, #444466)',
};
const ButtonGradientStyle = {
  'border-radius': '0.25rem',
  'border': '1px solid #444466',
  'background-image': 'linear-gradient(#222244, #444466, #444466, #222244)',
};
const ButtonStyle = {
  'border-radius': '0.25rem',
  'border': '1px solid #444466',
  'background-image': 'linear-gradient(#444466, #444466)',
};
export const Autolathe = (props, context) => {
  const { act, data } = useBackend(context);
  // Extract `health` and `color` variables from the `data` object.
  const {
    materialtotal,
    materialsmax,
    materials = [],
    categories = [],
    designs = [],
    active,
    num_per_line = 4,
  } = data;
  const cat_basis = num_per_line < 1 ? 2 : "" + (100 / num_per_line) - 1 + "%";
  const grow_shrink = true; // num_per_line < 1 ? false : true;
  const num_blanks = num_per_line - (categories.length % num_per_line);
  const [
    current_category,
    setCategory,
  ] = useLocalState(context, 'current_category', "None");
  const filteredmaterials = materials.length
    ? materials.filter(material => material.mineral_amount > 0)
    : [];
  return (
    <Window
      width={800}
      height={600}>
      <Window.Content scrollable>
        <Section title="Total Materials" style={BGGradientTopDownStyle}>
          <LabeledList>
            <LabeledList.Item
              label="Total">
              <ProgressBar
                value={materialtotal}
                minValue={0}
                maxValue={materialsmax}
                ranges={{
                  "good": [materialsmax * 0.85, materialsmax],
                  "average": [materialsmax * 0.25, materialsmax * 0.85],
                  "bad": [0, materialsmax * 0.25],
                }}>
                {materialtotal + '/' + materialsmax + ' cm³'}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item>
              {filteredmaterials.length > 0 && (
                <Collapsible title="Materials">
                  <LabeledList>
                    {filteredmaterials.map(filteredmaterial => (
                      <LabeledList.Item
                        key={filteredmaterial.id}
                        label={capitalize(filteredmaterial.name)}>
                        <ProgressBar
                          style={{
                            transform: 'scaleX(-1) scaleY(1)',
                          }}
                          value={materialsmax - filteredmaterial.mineral_amount}
                          maxValue={materialsmax}
                          color="black"
                          backgroundColor={filteredmaterial.matcolour}>
                          <div style={{ transform: 'scaleX(-1)' }}>{filteredmaterial.mineral_amount + ' cm³'}</div>
                        </ProgressBar>
                      </LabeledList.Item>
                    ))}
                  </LabeledList>
                </Collapsible>)}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          style={BGGradientTopDownStyle}
          title="Search">
          <Input fluid
            placeholder="Search Recipes..."
            selfClear
            onChange={(e, value) => {
              if (value.length) {
                act('search', {
                  to_search: value,
                });
                setCategory('results for "' + value + '"');
              }
            }} />
        </Section>
        <Section title="Categories"
          style={BGGradientTopDownStyle}>
          <Flex direction="row" wrap="wrap">
            {categories.map(category => (
              <Flex.Item
                key={category}
                grow={grow_shrink}
                shrink={grow_shrink}
                basis={cat_basis}
                style={{
                  margin: '2px',
                }}>
                {/* eslint-disable-next-line react/jsx-key */}
                <Button
                  selected={current_category === category}
                  content={category}
                  overflow="hidden"
                  height="100%"
                  width="100%"
                  onClick={() => {
                    act('category', {
                      selectedCategory: category,
                    });
                    setCategory(category);
                  }} />
              </Flex.Item>
            ))}
            {num_blanks > 0 && (
              <Flex.Item
                key="blank"
                grow={grow_shrink}
                shrink={grow_shrink}
                basis={cat_basis}
                style={{
                  margin: '2px',
                }}>
                {/* <Button
                  disabled
                  height="100%"
                  width="100%" /> */}
              </Flex.Item>
            )}
          </Flex>
        </Section>
        {current_category.toString() !== "None" && (
          <Section
            title={'Displaying ' + current_category.toString()}
            buttons={(
              <Button
                icon="times"
                content="Close Category"
                onClick={() => {
                  act('menu');
                  setCategory("None");
                }} />
            )}
            style={BGStyle}>
            {active === 1 && (
              <Dimmer fontSize="32px">
                <Icon name="cog" spin />
                {'Building items...'}
              </Dimmer>
            )}
            <Stack fill vertical>
              <Stack.Item>
                {designs.length
                  && (designs.map(design => (
                    <Box
                      key={design.id}
                      py="0.25rem"
                      px="0.5rem"
                      my="0.25rem"
                      width="100%"
                      textAlign="left"
                      style={{
                        'border-radius': '0.25rem',
                        'border': '1px solid #444466',
                        'background-image': 'linear-gradient(#222244, #444466, #444466, #222244)',
                      }}>
                      <Stack fill vertical key={design.id}>
                        <Stack.Item>
                          <Stack fill>
                            <Stack.Item grow={1}>
                              <Button
                                content={design.name}
                                disabled={design.buildable}
                                width="100%"
                                onClick={() => act('make', {
                                  id: design.id,
                                  multiplier: '1',
                                })} />
                            </Stack.Item>
                            <Stack.Item shrink={1}>
                              <Button
                                icon="hammer"
                                content="5"
                                width="100%"
                                disabled={!design.mult5}
                                onClick={() => act('make', {
                                  id: design.id,
                                  multiplier: '5',
                                })} />
                            </Stack.Item>
                            <Stack.Item shrink={1}>
                              <Button
                                icon="hammer"
                                content="10"
                                width="100%"
                                disabled={!design.mult10}
                                onClick={() => act('make', {
                                  id: design.id,
                                  multiplier: '10',
                                })} />
                            </Stack.Item>
                            <Stack.Item shrink={1}>
                              <Button
                                icon="hammer"
                                width="100%"
                                content="25"
                                disabled={!design.mult25}
                                onClick={() => act('make', {
                                  id: design.id,
                                  multiplier: '25',
                                })} />
                            </Stack.Item>
                            <Stack.Item basis="15%">
                              <Button.Input
                                content={"[Max:" + design.maxmult + ']'}
                                width="100%"
                                maxValue={design.maxmult}
                                disabled={design.buildable}
                                backgroundColor={design.buildable ? '#999999' : 'default'}
                                onCommit={(e, value) => act('make', {
                                  id: design.id,
                                  multiplier: value,
                                })} />
                            </Stack.Item>
                          </Stack>
                        </Stack.Item>
                        <Stack.Item>
                          {design.cost}
                        </Stack.Item>
                      </Stack>
                    </Box>
                  )))}
              </Stack.Item>
            </Stack>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
