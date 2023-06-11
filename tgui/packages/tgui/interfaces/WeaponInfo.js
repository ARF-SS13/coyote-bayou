import { useBackend } from '../backend';
import { Button, LabeledList, Section, ProgressBar, Flex, Stack, Icon, Fragment, Box, Table } from '../components';
import { Window } from '../layouts';

export const WeaponInfo = (props, context) => {
  const { act, data } = useBackend(context);
  // Extract `health` and `color` variables from the `data` object.
  return (
    <Window
      width={400}
      height={600}
      resizable>
      <Window.Content scrollable>
        <Flex>
          <Flex.Item basis="50%">
            <Stack fill vertical>
              <Stack.Item>
                <RangedInfo />
              </Stack.Item>
              <Stack.Item>
                <MeleeInfo />
              </Stack.Item>
              <Stack.Item>
                <MagazineInfo />
              </Stack.Item>
              <Stack.Item grow>
                <ProjectileInfo />
              </Stack.Item>
            </Stack>
          </Flex.Item>
          <Flex.Item basis="50%">
            <Stack fill vertical>
              <Stack.Item>
                <RecoilInfo />
              </Stack.Item>
              <Stack.Item>
                <FiremodeInfo />
              </Stack.Item>
              <Stack.Item>
                <AttachmentInfo />
              </Stack.Item>
            </Stack>
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};

export const RangedInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    gun_damage_multiplier,
    gun_penetration_multiplier,
    firemode_current,
    gun_chambered,
  } = data;
  const fixed_damage_multiplier = gun_damage_multiplier.toFixed(2);
  const fixed_penetration_multiplier = gun_penetration_multiplier.toFixed(2);
  const firemode_rpm = firemode_current["fire_rate"];
  const firemode_name = firemode_current["action_kind"];
  const firemode_desc = firemode_current["desc"];
  let damage_value = Number(gun_chambered.projectile_damage) * Number(gun_damage_multiplier);
  if (!!gun_chambered){
    let unfixed_damage_value = gun_chambered.projectile_damage * gun_damage_multiplier;
    damage_value = gun_chambered.projectile_damage + " x " + fixed_damage_multiplier + " = " + unfixed_damage_value.toFixed(1);
  } else {
    damage_value = fixed_damage_multiplier + "x"
  };
  return (
    <Section title="Ranged Data">
      <LabeledList>
        <LabeledList.Item label="DMG">
          {damage_value}
        </LabeledList.Item>
        <LabeledList.Item label="AP">
          {fixed_penetration_multiplier}x
        </LabeledList.Item>
        <LabeledList.Item label="Fire Delay">
          {firemode_rpm} RPM
        </LabeledList.Item>
      </LabeledList>
      <Button fluid content={firemode_name} tooltip={firemode_desc} />
    </Section>
  );
};

export const MeleeInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    gun_melee,
    gun_melee_wielded,
    gun_armor_penetration,
  } = data;
  return (
    <Section title="Melee Data">
      <LabeledList>
        <LabeledList.Item label="1-2 Hand DMG">
          {gun_melee} : {gun_melee_wielded}
        </LabeledList.Item>
        <LabeledList.Item label="AP">
          {gun_armor_penetration}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

export const MagazineInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_magazine,
  } = data;
  if (has_magazine) {
    return (
      <MagazineInfoLoaded />
    );
  } else {
    return (
      <MagazineInfoEmpty />
    );
  };
};

export const MagazineInfoLoaded = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    magazine_name,
    magazine_calibers,
    shots_remaining,
    shots_max,
  } = data;
  return (
    <Section
      title={magazine_name}
      buttons={(
        <Button
          content={<Icon name="fa-solid fa-butter" />}
          tooltip={magazine_calibers}
          tooltipPosition="right"
          tooltipStyle="large" >
        </Button>
      )}>
      <ProgressBar
        value={shots_remaining}
        maxValue={shots_max} >
        <Box color="label" bold textAlign="center">
          {shots_remaining} / {shots_max}
        </Box>
      </ProgressBar>
    </Section>
  );
};

export const MagazineInfoEmpty = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    accepted_magazines,
  } = data;
  return (
    <Section title="NO MAGAZINE">
      <Button
        fluid
        content="Accepts..."
        tooltip={accepted_magazines}
        tooltipPosition="right"
        tooltipStyle="large" />
    </Section>
  );
};

export const ProjectileInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    casing_name,
    casing_pellets,
    casing_variance,
    casing_fire_power,
    casing_damage_threshold_penetration,
    projectile_name,
    projectile_damage,
    projectile_damage_type,
    projectile_flag,
    projectile_stamina,
    projectile_recoil,
    projectile_hitscan,
    projectile_range,
    projectile_supereffective_damage,
    projectile_supereffective_faction,
    projectile_wound_bonus,
    projectile_bare_wound_bonus,
    projectile_sharpness,
    projectile_spread,
    projectile_armor_penetration,
    projectile_speed,
    no_data,
  } = data;
  if (!casing_name) {
    return (
      <Section title="NOT LOADED">
        No data available!
      </Section>
    );
  };
  if(!projectile_name) {
    return (
      <Section
        title={casing_name} >
        CASING EMPTY.
      </Section>
    );
  };
  let damage_text;
  if (casing_pellets > 1) {
    damage_text = projectile_damage + "x" + casing_pellets + " " + projectile_damage_type;
  } else {
    damage_text = projectile_damage + " " + projectile_damage_type;
  };
  const spread_text = "±" + (Number(projectile_spread) + Number(casing_variance)) + " degrees";
  return (
    <Section
      title={casing_name}
      buttons={(
        <Damage2Icon type = {projectile_damage_type} armor = {projectile_flag} />
      )}>
      <LabeledList>
        <LabeledList.Item label="Damage">
          {damage_text}
        </LabeledList.Item>
        <LabeledList.Item label="Stamina">
          {projectile_stamina} <Button color="transparent" content="R3Bs" tooltip="Rubber Beany Baby Bags (at 200 meters)" tooltipStyle="large" />
        </LabeledList.Item>
        <LabeledList.Item label="AP">
          {projectile_armor_penetration} <Button color="transparent" content="ABR" tooltip="Armor Bypass Ratio" tooltipStyle="large" />
        </LabeledList.Item>
        <LabeledList.Item label="DT Bypass">
          {casing_damage_threshold_penetration} <Button color="transparent" content="mmNS" tooltip="Millimeters of Nash Steel" tooltipStyle="large" />
        </LabeledList.Item>
        <LabeledList.Item label="Spread">
          {spread_text}
        </LabeledList.Item>
        <LabeledList.Item label="Recoil">
          {projectile_recoil} <Button color="transparent" content="RIF" tooltip="Recoil Impulse Factor" tooltipStyle="large" />
        </LabeledList.Item>
        <LabeledList.Item label="Speed">
          {projectile_hitscan ? "Fast" : projectile_speed}
        </LabeledList.Item>
        <LabeledList.Item label="Wound">
          {projectile_wound_bonus} <Button color="transparent" content="cmS" tooltip="Centimeters of Suture" tooltipStyle="large" />
        </LabeledList.Item>
        <LabeledList.Item label="Bare Wound">
          {projectile_bare_wound_bonus} <Button color="transparent" content="cmS" tooltip="Centimeters of Suture" tooltipStyle="large" />
        </LabeledList.Item>
        <LabeledList.Item label="Sharpness">
          {projectile_sharpness}
        </LabeledList.Item>
        <LabeledList.Item label="Firepower">
          {casing_fire_power} <Button color="transparent" content="dK" tooltip="Deci-Kellies (normalized)" tooltipStyle="large" />
        </LabeledList.Item>
        <LabeledList.Item label="Range">
          {projectile_range}
        </LabeledList.Item>
        {projectile_supereffective_damage && (
          <LabeledList.Item label="Supereffective">
            {projectile_supereffective_damage} vs {projectile_supereffective_faction}
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};

const RecoilInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    recoil_unwielded,
    recoil_wielded,
    total_recoil_unwielded,
    total_recoil_wielded,
  } = data;
  let unwielded_bar_number = recoil_unwielded;
  let wielded_bar_number = recoil_wielded;
  if (!!total_recoil_unwielded) {
    unwielded_bar_number = total_recoil_unwielded;
  };
  if (!!total_recoil_wielded) {
    wielded_bar_number = total_recoil_wielded;
  };
  return (
    <Section
      title="Recoil"
      width="100%">
      <Flex direction="row" wrap="wrap">
        <Flex.Item>
          1-Handed Base mult penis
        </Flex.Item>
        <Flex.Item>
          <ProgressBar
            value={recoil_unwielded}
            maxValue={2}
            ranges={{
              good: [-Infinity, 0.9],
              average: [0.9, 1.7],
              bad: [1.7, Infinity],
            }}>
            <Box
              width="100%"
              textAlign="center">
              {recoil_unwielded}x
            </Box>
          </ProgressBar>
        </Flex.Item>
        <Flex.Item>
          1-Handed Modded mult
        </Flex.Item>
        <Flex.Item>
          <ProgressBar
            value={total_recoil_unwielded}
            maxValue={2}
            ranges={{
              good: [-Infinity, 0.9],
              average: [0.9, 1.7],
              bad: [1.7, Infinity],
            }}>
            <Box
              width="100%"
              textAlign="center">
              {unwielded_bar_number}x
            </Box>
          </ProgressBar>
        </Flex.Item>
        <Flex.Item>
          2-Handed Base mult
        </Flex.Item>
        <Flex.Item>
          <ProgressBar
            value={recoil_unwielded}
            maxValue={2}
            ranges={{
              good: [-Infinity, 0.9],
              average: [0.9, 1.7],
              bad: [1.7, Infinity],
            }}>
            <Box
              width="100%"
              textAlign="center">
              {recoil_unwielded}x
            </Box>
          </ProgressBar>
        </Flex.Item>
        <Flex.Item>
          2-Handed Modded mult
        </Flex.Item>
        <Flex.Item>
          <ProgressBar
            value={total_recoil_unwielded}
            maxValue={2}
            ranges={{
              good: [-Infinity, 0.9],
              average: [0.9, 1.7],
              bad: [1.7, Infinity],
            }}>
            <Box
              width="100%"
              textAlign="center">
              {unwielded_bar_number}x
            </Box>
          </ProgressBar>
        </Flex.Item>
      </Flex>
    </Section>
  );
};

const FiremodeInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    firemode_info,
    firemode_count,
  } = data;
  if (!firemode_count) {
    return (
      <Section title="Firemodes">
        <Box color="bad">
          No firemodes! This is probably a bug! Uh oh~
        </Box>
      </Section>
    );
  };
  return (
    <Section title="Firemodes">
      <Flex>
        {firemode_info.map(firemodevalue => (
          <Flex.Item key={firemodevalue.index} basis="45%">
            <Button
              content={firemodevalue.name}
              color={firemodevalue.current ? ('red') : (null)}
              tooltip={firemodevalue.desc}
              tooltipPosition="bottom"
              tooltipStyle="max-width: 300px"
              onClick={firemodevalue.current ? (null) : (() => act('firemode', {
                firemode: firemodevalue.index,
              }))} />
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};

const AttachmentInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    attachments,
  } = data;
  if (!attachments.length) {
    return (
      <Section title="Attachments">
        <Box color="bad">
          No attachments!
        </Box>
      </Section>
    );
  };
  return (
    <Section title="Attachments">
      <Flex>
        {attachments.map(attachmentvalue => (
          <Flex.Item key={attachmentvalue.name} grow={1}>
            <Button
              content={attachmentvalue.name}
              tooltip={attachmentvalue.desc}
              tooltipPosition="bottom"
              tooltipStyle="max-width: 300px" />
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};

const Damage2Icon = (props) => {
  const { type, armor } = props;
  let type_icon;
  let type_text;
  let armor_icon;
  let armor_text;
  switch (type) {
    case "brute":
      type_icon = "fa-solid fa-hand-fist";
      type_text = "Brute";
      break;
    case "burn":
      type_icon = "fa-solid fa-fire";
      type_text = "Burn";
      break;
    case "toxin":
      type_icon = "fa-solid fa-biohazard";
      type_text = "Toxin";
      break;
    case "oxy":
      type_icon = "fa-solid fa-lungs";
      type_text = "Oxy";
      break;
    case "clone":
      type_icon = "fa-regular fa-user";
      type_text = "Clone";
      break;
    case "stamina":
      type_icon = "fa-solid fa-bed";
      type_text = "Stamina";
      break;
    case "brain":
      type_icon = "fa-solid fa-brain";
      type_text = "Brain";
      break;
    case "radiation":
      type_icon = "fa-solid fa-radiation";
      type_text = "Radiation";
  };
  switch (armor) {
    case "melee":
      armor_icon = "fa-solid fa-hand-fist";
      armor_text = "Melee";
      break;
    case "bullet":
      armor_icon = "fa-solid fa-bullseye";
      armor_text = "Bullet";
      break;
    case "laser":
      armor_icon = "fa-solid fa-bullseye";
      armor_text = "Laser";
      break;
    case "energy":
      armor_icon = "fa-solid fa-bolt";
      armor_text = "Energy";
      break;
    case "bomb":
      armor_icon = "fa-solid fa-bomb";
      armor_text = "Bomb";
      break;
    case "bio":
      armor_icon = "fa-solid fa-biohazard";
      armor_text = "Bio";
      break;
    case "rad":
      armor_icon = "fa-solid fa-radiation";
      armor_text = "Rad";
      break;
  };
  return (
    <Fragment>
      <Button
        content={<Icon name={type_icon} />}
        tooltip={type_text}
        tooltipPosition="bottom"
        tooltipStyle="large" />
      <Button
        content={<Icon name={armor_icon} />}
        tooltip={armor_text}
        tooltipPosition="bottom"
        tooltipStyle="large" />
    </Fragment>
  );
};

