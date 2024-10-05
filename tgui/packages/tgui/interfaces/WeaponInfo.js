import { useBackend } from '../backend';
import { Button, LabeledList, Section, ProgressBar, Flex, Stack, Icon, Fragment, Box, Table, Tooltip } from '../components';
import { Window } from '../layouts';

export const WeaponInfo = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      width={700}
      height={600}
      resizable>
      <Window.Content scrollable>
        <Table>
          <Table.Row>
            <Table.Cell width="50%" >
              <RangedInfo />
            </Table.Cell>
            <Table.Cell width="50%">
              <MeleeInfo />
            </Table.Cell>
          </Table.Row>

          <Table.Row>
            <Table.Cell width="50%" py="0.5rem">
              <MagazineInfo />
              <FiremodeInfo />
            </Table.Cell>
            <Table.Cell width="50%">
              <RecoilInfo />
            </Table.Cell>
          </Table.Row>

          <Table.Row>
            <Table.Cell width="50%">
              <ProjectileInfo />
            </Table.Cell>
            <Table.Cell width="50%">
              <AttachmentInfo />
            </Table.Cell>
          </Table.Row>
        </Table>
      </Window.Content>
    </Window>
  );
};

export const RangedInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    gun_name = "Really Cool Gun",
    gun_damage_multiplier = 1,
    gun_penetration_multiplier = 0,
    gun_spread = 0,
    firemode_current = {},
    gun_chambered = {},
    gun_is_chambered = false,
    flintlock_load_time = 0,
    flintlock_prefire_time = 0,
    flintlock_prefire_1SD = 0,
  } = data;
  let true_firemode = firemode_current || {};
  if (!firemode_current || !true_firemode["fire_rate"]) {
    true_firemode = {}; // eat my a ss
    true_firemode.fire_rate = "N/A";
    true_firemode.action_kind = "Shoot";
    true_firemode.desc = "Makes weapon shoot!";
  }
  let flintable = false;
  let flintable_loadtime = 0;
  let flintable_prefiretime = 0;
  let flintable_prefire_1SD = 0;
  if (flintlock_load_time > 0
      && flintlock_prefire_time > 0
      && flintlock_prefire_1SD > 0) {
    flintable = true;
    flintable_loadtime = `${flintlock_load_time}s`;
    flintable_prefiretime
      = `~${flintlock_prefire_time}s ±${flintlock_prefire_1SD}s (1SD)`;
  }
  const prefixed_dm = gun_damage_multiplier || 0;
  const prefixed_pm = gun_penetration_multiplier || 0;
  const fixed_damage_multiplier = prefixed_dm.toFixed(2);
  const fixed_penetration_multiplier = prefixed_pm.toFixed(2);
  const firemode_rpm = true_firemode.fire_rate || "N/A";
  const firemode_name = true_firemode.action_kind || "Shoot";
  const firemode_desc = true_firemode.desc || "Makes weapon shoot!";
  let damage_value;
  if (gun_is_chambered && !!gun_chambered.projectile_damage) {
    const plts = gun_chambered.pellets;
    const fxdm = fixed_damage_multiplier;
    const pdv = gun_chambered.projectile_damage || 0;
    const gdmg = gun_damage_multiplier || 0;
    let ufdv = Number(pdv) * Number(gdmg);
    if (gun_chambered.pellets > 1) {
      // oh yeah thats much more readable, thanks linter
      ufdv = ufdv * Number(plts);
      damage_value = ufdv.toFixed(1) + " = (" + pdv + "x" + plts + ")x" + fxdm;
    } else {
      damage_value = ufdv.toFixed(1) + " = " + pdv + " x " + fxdm;
    }
  } else {
    damage_value = fixed_damage_multiplier + "x";
  }
  return (
    <Section title={<Tooltipify name={"Ranged Data"} tip={gun_name} big={1} />}>
      <Table
        px="1rem"
        className="candystripe"
        width="100%">
        <Table.Row>
          <Table.Cell bold textAlign="right" width="35%" color="label">
            <Tooltipify name={"Damage: "} tip={"Total Damage = (Projectile Base Damage * Pellets) * Gun Damage Multiplier."} />
          </Table.Cell>
          <Table.Cell>
            {damage_value}
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" width="35%" color="label">
            <Tooltipify name={"AP Mult: "} tip={"Multiplier to the AP on any projectile shot."} />
          </Table.Cell>
          <Table.Cell>
            {fixed_penetration_multiplier}x
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" width="35%" color="label">
            <Tooltipify name={"Base Spread: "} tip={"Inaccuracy inherent to the gun, in degrees from center."} />
          </Table.Cell>
          <Table.Cell>
            ± {gun_spread}°
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" width="35%" color="label">
            <Tooltipify name={"Fire Rate: "} tip={"Rounds per minute."} />
          </Table.Cell>
          <Table.Cell>
            {firemode_rpm}
          </Table.Cell>
        </Table.Row>

        {flintable ? (
          <Fragment>
            <Table.Row>
              <Table.Cell bold textAlign="right" width="35%" color="label">
                <Tooltipify name={"Load Time: "} tip={"Time to load the flintlock."} />
              </Table.Cell>
              <Table.Cell>
                {flintable_loadtime}
              </Table.Cell>
            </Table.Row>

            <Table.Row>
              <Table.Cell bold textAlign="right" width="35%" color="label">
                <Tooltipify name={"Prefire Time: "} tip={"Average prefire time, with 1 standard deviation."} />
              </Table.Cell>
              <Table.Cell>
                {flintable_prefiretime}
              </Table.Cell>
            </Table.Row>
          </Fragment>
        ) : null}

      </Table>
      <Box
        width="100%"
        height="fit-content"
        textAlign="center">
        <Tooltipify name={firemode_name} tip={firemode_desc} bigger={1} />
      </Box>
    </Section>
  );
};

export const MeleeInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    gun_name = "Really Cool Gun",
    gun_melee = 0,
    gun_melee_wielded = 0,
    gun_armor_penetration = 0,
  } = data;
  const prefixed_gap = gun_armor_penetration || 0;
  return (
    <Section title={<Tooltipify name={"Melee Data"} tip={gun_name} big={1} />} >
      <Table
        px="1rem"
        className="candystripe"
        width="100%">
        <Table.Row>
          <Table.Cell bold textAlign="right" width="35%" color="label">
            <Tooltipify name={"1H DMG: "} tip={"Damage when wielded in one hand."} />
          </Table.Cell>
          <Table.Cell>
            {gun_melee}
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" width="35%" color="label">
            <Tooltipify name={"2H DMG: "} tip={"Damage when wielded in two hands."} />
          </Table.Cell>
          <Table.Cell>
            {gun_melee_wielded}
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" width="35%" color="label">
            <Tooltipify name={"AP: "} tip={"Amount of Damage Resistance that this will bypass."} />
          </Table.Cell>
          <Table.Cell>
            {prefixed_gap.toFixed(2)}
          </Table.Cell>
        </Table.Row>
      </Table>
    </Section>
  );
};

export const MagazineInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_magazine = false,
  } = data;
  if (has_magazine) {
    return (
      <MagazineInfoLoaded />
    );
  } else {
    return (
      <MagazineInfoEmpty />
    );
  }
};

export const MagazineInfoLoaded = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    magazine_name,
    magazine_calibers,
    shots_remaining,
    shots_max,
    gun_is_chambered,
    gun_chambered,
    cockable,
    cocked,
  } = data;
  let chamberedCasing;
  const cN = gun_chambered.casing_name; // FUCK YOU ESLINT IM NOT AFRAID OF LO
  const cC = gun_chambered.casing_caliber;
  if (gun_chambered.casing_name) {
    chamberedCasing = <Tooltipify name={cN} tip={cC} />;
  } else {
    chamberedCasing = <Tooltipify name="Empty" tip="Bullet goes here." />;
  }
  let cockRead;
  let cockColored;
  if (cockable) {
    let cKnm;
    let cKtt;
    let cKcl;
    if (cocked) {
      if (gun_is_chambered) {
        cKnm = "Cocked";
        cKtt = "Gun is cocked and ready to fire!";
        cKcl = 'green';
      } else {
        cKnm = "Cocked";
        cKtt = "Gun is cocked, but still needs something to fire!";
        cKcl = 'green';
      }
    } else {
      cKnm = "Uncocked";
      cKtt = "This gun needs to be cocked before you can shoot it!";
      cKcl = 'red';
    }
    cockRead = <Tooltipify name={cKnm} tip={cKtt} />;
    cockColored = <Box color={cKcl}>{cockRead}</Box>;
  }
  const thagomizer = "accepts: " + magazine_calibers; // thanks mike
  return (
    <Section
      title={<Tooltipify name="Ammunition" tip={thagomizer} big={1} />}>
      <Box textAlign="center">
        <Box bold>
          <Tooltipify name={magazine_name} tip={thagomizer} big={1} />
        </Box>
        {cockColored}
        {chamberedCasing}
      </Box>
      <ProgressBar
        value={shots_remaining}
        maxValue={shots_max} >
        <Box bold textAlign="center">
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
  const thagomizer = "accepts: " + accepted_magazines;
  const emptyMizer = "This weapon doesn't have a magazine!";
  return (
    <Section title={<Tooltipify name="No Magazine" tip={emptyMizer} big={1} />}>
      <Tooltipify name="Insert one!" tip={thagomizer} />
    </Section>
  );
};

export const ProjectileInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    gun_chambered,
    gun_is_chambered,
    gun_chambered_loaded,
  } = data;
  if (!gun_is_chambered) {
    return (
      <Section title={<Tooltipify name="NOT CHAMBERED" tip="404: Ammo not found." big={1} />}>
        <Tooltipify name="No Data Available!" tip={"This gun doesn't have anything loded!"} />
      </Section>
    );
  }
  const {
    casing_name,
    casing_caliber,
    casing_pellets,
    casing_variance,
    casing_fire_power,
    casing_damage_threshold_penetration,
    projectile_name,
    projectile_damage,
    projectile_damage_total,
    projectile_damage_type,
    projectile_flag,
    projectile_stamina,
    projectile_recoil,
    projectile_hitscan,
    projectile_range,
    projectile_supereffective_damage,
    projectile_supereffective_faction,
    projectile_wound_bonus,
    projectile_sharpness,
    projectile_spread,
    projectile_armor_penetration,
    projectile_speed_unit,
    projectile_speed_unit_words,
    projectile_speed,
  } = gun_chambered;
  let itShoots = "It is " + casing_caliber + " and shoots " + casing_name + "!";
  if (!gun_chambered_loaded) {
    itShoots = itShoots + " At least it would if it wasn't empty.";
    return (
      <Section
        title={<Tooltipify name={casing_name} tip={itShoots} big={1} />} >
        <Tooltipify name="No Data Available!" tip={"This casing is empty!"} />
      </Section>
    );
  }
  let pS = projectile_speed;
  let pST = projectile_speed_unit_words;
  let pSTu = projectile_speed_unit;
  if (projectile_hitscan) {
    pS = "∞";
    pST = "Fast";
    pSTu = "Hitscan!";
  }
  // WHY YES LINTEr WHY EVER WOULD I NEED 81 CHARACTERS ON A LINE
  const pD = projectile_damage;
  const pDTP = projectile_damage_total;
  const pDTy = projectile_damage_type;
  const pDf = projectile_flag;
  const damage_icon = <Damage2Icon type={pDTy} armor={pDf} />;
  let damage_text = <Tooltipify name={pD} tip={pDTP} />;
  if (casing_pellets > 1) {
    damage_text = damage_text + "x" + casing_pellets;
  }
  return (
    <Section title={<Tooltipify name={casing_name} tip={itShoots} big={1} />}>
      <Table
        px="1rem"
        className="candystripe"
        width="100%">
        <Table.Row>
          <Table.Cell bold textAlign="right" width="35%" color="label">
            <Tooltipify name="Damage:" tip="Base damage." />
          </Table.Cell>
          <Table.Cell>
            {damage_text} {damage_icon}
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" color="label">
            <Tooltipify name="Spread" tip="Base inaccuracy in degrees from straight ahead, before recoil is factored in." />
          </Table.Cell>
          <Table.Cell>
            ± {Number(projectile_spread) + Number(casing_variance)}°
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" color="label">
            <Tooltipify name="Recoil:" tip="Base recoil applied to the user when fired, before the gun's modifiers are factored in." />
          </Table.Cell>
          <Table.Cell>
            {projectile_recoil} <Tooltipify name="RIF" tip="Recoil Impulse Factor" fade={1} />
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" color="label">
            <Tooltipify name="Speed:" tip="How fast the projectile moves." />
          </Table.Cell>
          <Table.Cell>
            {pS} {<Tooltipify name={pSTu} tip={pST} fade={1} />}
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" color="label">
            <Tooltipify name="DR Pierce:" tip="Amount of armor damage resistance (percent reduction) it ignores on the target." />
          </Table.Cell>
          <Table.Cell>
            {projectile_armor_penetration} <Tooltipify name="ABR" tip="Armor Bypass Ratio" fade={1} />
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" color="label">
            <Tooltipify name="DT Pierce:" tip="Points of armor damage threshold (flat reduction) it ignores on the target." />
          </Table.Cell>
          <Table.Cell>
            {casing_damage_threshold_penetration} <Tooltipify name="mmNS" tip="Millimeters of Nash Steel" fade={1} />
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" color="label">
            <Tooltipify name="Range:" tip="Max distance in tiles this projectile can travel." />
          </Table.Cell>
          <Table.Cell>
            {projectile_range} <Tooltipify name="ftm" tip="Fathoms" fade={1} />
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" color="label">
            <Tooltipify name="Firepower" tip="Explosive force imparted to the gun. Mostly relevant to improvised and garbage guns." />
          </Table.Cell>
          <Table.Cell>
            {casing_fire_power} <Tooltipify name="dK" tip="deciKellies" fade={1} />
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" color="label">
            <Tooltipify name="Wound" tip="Amount of extra wounding damage applied to a non-simple target (Anything that can have underwear)." />
          </Table.Cell>
          <Table.Cell>
            {projectile_wound_bonus} <Tooltipify name="S-M" tip="Suture-Meters" fade={1} />
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell bold textAlign="right" color="label">
            <Tooltipify name="Sharpness" tip="Type of wound caused when enough damage is applied to a non-simple target (Anything that can wear a scarf)." />
          </Table.Cell>
          <Table.Cell>
            {projectile_sharpness}
          </Table.Cell>
        </Table.Row>

        {!!projectile_supereffective_damage
        && !!projectile_supereffective_faction && (
          <Table.Row>
            <Table.Cell bold textAlign="right" color="label">
              <Tooltipify name="Supereffective" tip="Extra damage caused to specific kinds of targets. Is always brute." />
            </Table.Cell>
            <Table.Cell>
              {<Tooltipify name={projectile_supereffective_damage} tip={"Effective against: " + projectile_supereffective_faction} />}
            </Table.Cell>
          </Table.Row>
        )}
      </Table>
    </Section>
  );
};

const RecoilInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    unmodded_recoil_unwielded = 1,
    modded_recoil_unwielded = 1,
    unmodded_recoil_wielded = 1,
    modded_recoil_wielded = 1,
    gun_recoil_scoot_title = "Affected by movement",
    gun_recoil_scoot_stats = "Movement applies its full recoil amount.",
  } = data;
  const recoilTip = "These multiply the shot projectile's \
  recoil calculations, based on whether you're wielding the gun or not. \
  The higher the number, the more recoil you'll get. The recoil is calculated \
  by multiplying the recoil of the projectile by the recoil of the gun.";
  const grst = gun_recoil_scoot_title;
  return (
    <Section
      title={<Tooltipify name="Recoil Multipliers" tip={recoilTip} big={1} />}
      width="100%"
      textAlign="center">
      <Table width="100%" textAlign="center">
        <Table.Row>
          <Table.Cell width="25%" bold={1}>
            <Tooltipify name="1-HAND" tip="Unwielded recoil multipliers." />
          </Table.Cell>
          <Table.Cell>
            <hr />
          </Table.Cell>
        </Table.Row>
        <Table.Row pb="1em">
          <Table.Cell>
            <Tooltipify name="Base" tip="Unwielded recoil multipliers, before attachments are factored in." />
          </Table.Cell>
          <Table.Cell>
            <ProgressBar
              value={unmodded_recoil_unwielded}
              maxValue={2}
              ranges={{
                good: [-Infinity, 0.9],
                average: [0.9, 1.7],
                bad: [1.7, Infinity],
              }}>
              <Box
                width="100%"
                textAlign="center">
                {unmodded_recoil_unwielded}x
              </Box>
            </ProgressBar>
          </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell>
            <Tooltipify name="Modded" tip="Unwielded recoil multipliers, after attachments are factored in." />
          </Table.Cell>
          <Table.Cell>
            <ProgressBar
              value={modded_recoil_unwielded}
              maxValue={2}
              ranges={{
                good: [-Infinity, 0.9],
                average: [0.9, 1.7],
                bad: [1.7, Infinity],
              }}>
              <Box
                width="100%"
                textAlign="center">
                {modded_recoil_unwielded}x
              </Box>
            </ProgressBar>
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell>
            <br />
          </Table.Cell>
          <Table.Cell>
            <br />
          </Table.Cell>
        </Table.Row>

        <Table.Row>
          <Table.Cell width="25%" bold={1}>
            <Tooltipify name="2-HAND" tip="Wielded recoil multipliers." />
          </Table.Cell>
          <Table.Cell>
            <hr />
          </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell>
            <Tooltipify name="Base" tip="Wielded recoil multipliers, before attachments are factored in." />
          </Table.Cell>
          <Table.Cell>
            <ProgressBar
              value={unmodded_recoil_wielded}
              maxValue={2}
              ranges={{
                good: [-Infinity, 0.9],
                average: [0.9, 1.7],
                bad: [1.7, Infinity],
              }}>
              <Box
                width="100%"
                textAlign="center">
                {unmodded_recoil_wielded}x
              </Box>
            </ProgressBar>
          </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell>
            <Tooltipify name="Modded" tip="Wielded recoil multipliers, after attachments are factored in." />
          </Table.Cell>
          <Table.Cell>
            <ProgressBar
              value={modded_recoil_wielded}
              maxValue={2}
              ranges={{
                good: [-Infinity, 0.9],
                average: [0.9, 1.7],
                bad: [1.7, Infinity],
              }}>
              <Box
                width="100%"
                textAlign="center">
                {modded_recoil_wielded}x
              </Box>
            </ProgressBar>
          </Table.Cell>
        </Table.Row>
      </Table>
      <Box
        width="100%"
        textAlign="center">
        <Tooltipify name={grst} tip={gun_recoil_scoot_stats} />
      </Box>
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
        <Box>
          Single-fire only!
        </Box>
      </Section>
    );
  }
  const FiremodeTip = "Firemodes are different ways to fire your gun. They can be switched between by clicking on them! The current firemode is highlighted in green.";
  return (
    <Section title={<Tooltipify name="Firemodes" tip={FiremodeTip} big={1} />}>
      <Stack fill vertical>
        {firemode_info.map(firemodevalue => (
          <Stack.Item key={firemodevalue.index}>
            <Button
              fluid
              content={firemodevalue.name}
              color={firemodevalue.current ? ('green') : (null)}
              tooltip={firemodevalue.desc}
              tooltipPosition="bottom"
              tooltipStyle="max-width: 300px"
              onClick={firemodevalue.current ? (null) : (() => act('firemode', {
                firemode: firemodevalue.index,
              }))} />
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};

const AttachmentInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    attachments = {},
  } = data;
  const AttachmentTip = "Attachments are things you can add to your gun to make it better*! They can be attached and detached by clicking on them.";
  if (!attachments || !attachments.length) {
    return (
      <Section title={<Tooltipify name="Attachments" tip={AttachmentTip} big={1} />}>
        <Tooltipify name="No attachments!" tip="Vanilla's a good flavor too." />
      </Section>
    );
  }
  return (
    <Section title={<Tooltipify name="Attachments" tip={AttachmentTip} big={1} />}>
      <Stack fill vertical>
        {attachments.map(attachmentvalue => (
          <Stack.Item key={attachmentvalue.name} grow={1}>
            <Button
              content={attachmentvalue.name}
              tooltip={attachmentvalue.desc}
              tooltipPosition="bottom"
              tooltipStyle="max-width: 300px"
              onClick={() => act('ExamineAttachment', {
                AttachmentID: attachmentvalue.attachment_index,
              })} />
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};

const Damage2Icon = (props) => {
  const { type, armor } = props;
  let type_icon;
  let type_text = "Deals ";
  let armor_icon;
  let armor_text = "Reduced by";
  switch (type) {
    case "brute":
      type_icon = "wrench";
      type_text = type_text + "Brute";
      break;
    case "fire":
      type_icon = "fire";
      type_text = type_text + "Burn";
      break;
    case "tox":
      type_icon = "biohazard";
      type_text = type_text + "Toxin";
      break;
    case "oxy":
      type_icon = "lungs";
      type_text = type_text + "Oxy";
      break;
    case "clone":
      type_icon = "user";
      type_text = type_text + "Clone";
      break;
    case "stamina":
      type_icon = "bed";
      type_text = type_text + "Stamina";
      break;
    case "brain":
      type_icon = "brain";
      type_text = type_text + "Brain";
      break;
    default:
      type_icon = "question";
      type_text = type_text + "Unknown";
  }
  switch (armor) {
    case "melee":
      armor_icon = "wrench";
      armor_text = armor_text + "Melee";
      break;
    case "bullet":
      armor_icon = "bullseye";
      armor_text = armor_text + "Bullet";
      break;
    case "laser":
      armor_icon = "lightbulb";
      armor_text = armor_text + "Laser";
      break;
    case "energy":
      armor_icon = "bolt";
      armor_text = armor_text + "Energy";
      break;
    case "bomb":
      armor_icon = "bomb";
      armor_text = armor_text + "Bomb";
      break;
    case "bio":
      armor_icon = "biohazard";
      armor_text = armor_text + "Bio";
      break;
    case "rad":
      armor_icon = "radiation";
      armor_text = armor_text + "Rad";
      break;
    default:
      armor_icon = "question";
      armor_text = armor_text + "Unknown";
  }
  type_text = type_text + " damage.";
  armor_text = armor_text + " armor.";
  return (
    <Fragment>
      <Tooltipify name={<Icon name={type_icon} />} tip={type_text} />
      <Tooltipify name={<Icon name={armor_icon} />} tip={armor_text} />
    </Fragment>
  );
};

const Tooltipify = (props) => {
  const { name, tip, big, fade, bigger } = props;
  let transparency = fade ? 0.5 : 1;
  let sizefont = bigger ? "1.5em" : "1em";
  if (big) {
    return (
      <Box bold fontSize={sizefont} textAlign="center" fluid>
        <Button
          opacity={transparency}
          backgroundColor="transparent"
          px={0}
          py={0}
          content={name}
          tooltip={tip}
          tooltipPosition="bottom" />
      </Box>
    );
  } else {
    return (
      <Button
        opacity={transparency}
        backgroundColor="transparent"
        px={0}
        py={0}
        content={name}
        tooltip={tip}
        tooltipPosition="bottom" />
    );
  }
};
