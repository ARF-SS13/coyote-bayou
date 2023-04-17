/* eslint-disable max-len */
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from "../backend";
import { Box, Button, Flex, Collapsible, Icon, LabeledList, NoticeBox, Section, Tabs } from "../components";
import { Window } from "../layouts";

const stats = [
  null,
  'average',
  'bad',
];

const digestModeToColor = {
  "Hold": null,
  "Dragon": "blue",
  "Digest": "red",
  "Absorb": "purple",
  "Unabsorb": "purple",
};

const digestModeToPreyMode = {
  "Hold": "being held.",
  "Digest": "being digested.",
  "Absorb": "being absorbed.",
  "Unabsorb": "being unabsorbed.",
  "Dragon": "being digested by a powerful creature.",
};

/**
 * There are three main sections to this UI.
 *  - The Inside Panel, where all relevant data for interacting with a belly you're in is located.
 *  - The Belly Selection Panel, where you can select what belly people will go into and customize the active one.
 *  - User Preferences, where you can adjust all of your vore preferences on the fly.
 */
export const VorePanel = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window width={700} height={660} theme="abstract" resizable>
      <Window.Content overflow="auto">
        {data.unsaved_changes && (
          <NoticeBox danger>
            <Flex>
              <Flex.Item basis="90%">
                Warning: Unsaved Changes!
              </Flex.Item>
              <Flex.Item>
                <Button
                  content="Save Prefs"
                  icon="save"
                  onClick={() => act("saveprefs")} />
              </Flex.Item>
            </Flex>
          </NoticeBox>
        ) || null}
        <VoreInsidePanel />
        <VoreBellySelectionAndCustomization />
        <VoreUserPreferences />
      </Window.Content>
    </Window>
  );
};

const VoreInsidePanel = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    absorbed,
    belly_name,
    belly_mode,
    desc,
    pred,
    contents,
    ref,
  } = data.inside;

  if (!belly_name) {
    return (
      <Section title="Inside">
        You aren&apos;t inside anyone.
      </Section>
    );
  }

  return (
    <Section title="Inside">
      <Box color="green" inline>You are currently {absorbed ? "absorbed into" : "inside"}</Box>&nbsp;
      <Box color="yellow" inline>{pred}&apos;s</Box>&nbsp;
      <Box color="red" inline>{belly_name}</Box>&nbsp;
      <Box color="yellow" inline>and you are</Box>&nbsp;
      <Box color={digestModeToColor[belly_mode]} inline>{digestModeToPreyMode[belly_mode]}</Box>&nbsp;
      <Box color="label">
        {desc}
      </Box>
      {contents.length && (
        <Collapsible title="Belly Contents">
          <VoreContentsPanel contents={contents} belly={ref} />
        </Collapsible>
      ) || "There is nothing else around you."}
    </Section>
  );
};

const VoreBellySelectionAndCustomization = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    our_bellies,
    selected,
  } = data;

  return (
    <Section title="My Bellies">
      <Tabs>
        {our_bellies.map(belly => (
          <Tabs.Tab
            key={belly.name}
            selected={belly.selected}
            textColor={digestModeToColor[belly.digest_mode]}
            onClick={() => act("bellypick", { bellypick: belly.ref })}>
            <Box inline textColor={belly.selected && digestModeToColor[belly.digest_mode] || null}>
              {belly.name} ({belly.contents})
            </Box>
          </Tabs.Tab>
        ))}
        <Tabs.Tab onClick={() => act("newbelly")}>
          New
          <Icon name="plus" ml={0.5} />
        </Tabs.Tab>
      </Tabs>
      {selected && <VoreSelectedBelly belly={selected} />}
    </Section>
  );
};

/**
 * Subtemplate of VoreBellySelectionAndCustomization
 */
const VoreSelectedBelly = (props, context) => {
  const { act } = useBackend(context);

  const { belly } = props;
  const {
    belly_name,
    is_wet,
    wet_loop,
    mode,
    verb,
    desc,
    sound,
    release_sound,
    can_taste,
    bulge_size,
    digestion_brute,
    digestion_burn,
    escapable,
    interacts,
    hork_trash,
    contents,
  } = belly;

  const [tabIndex, setTabIndex] = useLocalState(context, 'tabIndex', 0);

  return (
    <Fragment>
      <Tabs>
        <Tabs.Tab selected={tabIndex === 0} onClick={() => setTabIndex(0)}>
          Controls
        </Tabs.Tab>
        <Tabs.Tab selected={tabIndex === 1} onClick={() => setTabIndex(1)}>
          Options
        </Tabs.Tab>
        <Tabs.Tab selected={tabIndex === 2} onClick={() => setTabIndex(2)}>
          Contents ({contents.length})
        </Tabs.Tab>
        <Tabs.Tab selected={tabIndex === 3} onClick={() => setTabIndex(3)}>
          Interactions
        </Tabs.Tab>
      </Tabs>
      {tabIndex === 0 && (
        <LabeledList>
          <LabeledList.Item label="Name" buttons={
            <Fragment>
              <Button
                icon="arrow-left"
                tooltipPosition="left"
                tooltip="Move this belly tab left."
                onClick={() => act("move_belly", { dir: -1 })} />
              <Button
                icon="arrow-right"
                tooltipPosition="left"
                tooltip="Move this belly tab right."
                onClick={() => act("move_belly", { dir: 1 })} />
            </Fragment>
          }>
            <Button
              onClick={() => act("set_attribute", { attribute: "b_name" })}
              content={belly_name} />
          </LabeledList.Item>
          <LabeledList.Item label="Mode">
            <Button
              color={digestModeToColor[mode]}
              onClick={() => act("set_attribute", { attribute: "b_mode" })}
              content={mode} />
          </LabeledList.Item>
          <LabeledList.Item label="Flavor Text" buttons={
            <Button
              onClick={() => act("set_attribute", { attribute: "b_desc" })}
              icon="pen" />
          }>
            {desc}
          </LabeledList.Item>
          <LabeledList.Item label="Vore Verb">
            <Button
              onClick={() => act("set_attribute", { attribute: "b_verb" })}
              content={verb} />
          </LabeledList.Item>
          <LabeledList.Item label="Belly Messages">
            <Button
              onClick={() => act("set_attribute", { attribute: "b_msgs", msgtype: "dmp" })}
              content="Digest Message (to prey)" />
            <Button
              onClick={() => act("set_attribute", { attribute: "b_msgs", msgtype: "dmo" })}
              content="Digest Message (to you)" />
            <Button
              onClick={() => act("set_attribute", { attribute: "b_msgs", msgtype: "smo" })}
              content="Struggle Message (outside)" />
            <Button
              onClick={() => act("set_attribute", { attribute: "b_msgs", msgtype: "smi" })}
              content="Struggle Message (inside)" />
            <Button
              onClick={() => act("set_attribute", { attribute: "b_msgs", msgtype: "em" })}
              content="Examine Message (when full)" />
            <Button
              onClick={() => act("set_attribute", { attribute: "b_msgs", msgtype: "tr" })}
              content="Eject Trash Message (outside)" />
            <Button
              color="red"
              onClick={() => act("set_attribute", { attribute: "b_msgs", msgtype: "reset" })}
              content="Reset Messages" />
          </LabeledList.Item>
        </LabeledList>
      ) || tabIndex === 1 && (
        <Flex wrap="wrap">
          <Flex.Item basis="49.5%" grow={1}>
            <LabeledList>
              <LabeledList.Item label="Can Taste">
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_tastes" })}
                  icon={can_taste ? "toggle-on" : "toggle-off"}
                  selected={can_taste}
                  content={can_taste ? "Yes" : "No"} />
              </LabeledList.Item>
              <LabeledList.Item label="Fleshy Belly">
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_wetness" })}
                  icon={is_wet ? "toggle-on" : "toggle-off"}
                  selected={is_wet}
                  content={is_wet ? "Yes" : "No"} />
              </LabeledList.Item>
              <LabeledList.Item label="Internal Loop">
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_wetloop" })}
                  icon={wet_loop ? "toggle-on" : "toggle-off"}
                  selected={wet_loop}
                  content={wet_loop ? "Yes" : "No"} />
              </LabeledList.Item>
              <LabeledList.Item label="Eject Trash">
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_hork_trash" })}
                  icon={hork_trash ? "toggle-on" : "toggle-off"}
                  selected={hork_trash}
                  content={hork_trash ? "Yes" : "No"} />
              </LabeledList.Item>
            </LabeledList>
          </Flex.Item>
          <Flex.Item basis="49.5%" grow={1}>
            <LabeledList>
              <LabeledList.Item label="Vore Sound">
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_sound" })}
                  content={sound} />
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_soundtest" })}
                  icon="volume-up" />
              </LabeledList.Item>
              <LabeledList.Item label="Release Sound">
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_release" })}
                  content={release_sound} />
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_releasesoundtest" })}
                  icon="volume-up" />
              </LabeledList.Item>
              <LabeledList.Item label="Required Examine Size">
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_bulge_size" })}
                  content={bulge_size * 100 + "%"} />
              </LabeledList.Item>
              <LabeledList.Item label="Digestion Damage">
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_set_brute_damage" })}
                  content={digestion_brute + " Brute"} />
                <Button
                  onClick={() => act("set_attribute", { attribute: "b_set_burn_damage" })}
                  content={digestion_burn + " Burn"} />
              </LabeledList.Item>
            </LabeledList>
          </Flex.Item>
          <Flex.Item basis="100%" mtOptions={1}>
            <Button.Confirm
              fluid
              icon="exclamation-triangle"
              confirmIcon="trash"
              color="red"
              content="Delete Belly"
              confirmContent="This is irreversable!"
              onClick={() => act("set_attribute", { attribute: "b_del" })} />
          </Flex.Item>
        </Flex>
      ) || tabIndex === 2 && (
        <VoreContentsPanel outside contents={contents} />
      ) || tabIndex === 3 && (
        <Section title="Belly Interactions" buttons={
          <Button
            onClick={() => act("set_attribute", { attribute: "b_escapable" })}
            icon={escapable ? "toggle-on" : "toggle-off"}
            selected={escapable}
            content={escapable ? "Interactions On" : "Interactions Off"} />
        }>
          {escapable ? (
            <LabeledList>
              <LabeledList.Item label="Escape Chance">
                <Button
                  content={interacts.escapechance + "%"}
                  onClick={() => act("set_attribute", { attribute: "b_escapechance" })} />
              </LabeledList.Item>
              <LabeledList.Item label="Escape Time">
                <Button
                  content={interacts.escapetime / 10 + "s"}
                  onClick={() => act("set_attribute", { attribute: "b_escapetime" })} />
              </LabeledList.Item>
              <LabeledList.Divider />
              <LabeledList.Item label="Transfer Chance">
                <Button
                  content={interacts.transferchance + "%"}
                  onClick={() => act("set_attribute", { attribute: "b_transferchance" })} />
              </LabeledList.Item>
              <LabeledList.Item label="Transfer Location">
                <Button
                  content={interacts.transferlocation ? interacts.transferlocation : "Disabled"}
                  onClick={() => act("set_attribute", { attribute: "b_transferlocation" })} />
              </LabeledList.Item>
              <LabeledList.Divider />
              {/* <LabeledList.Item label="Absorb Chance">
                <Button
                  content={interacts.absorbchance + "%"}
                  onClick={() => act("set_attribute", { attribute: "b_absorbchance" })} />
              </LabeledList.Item> */}
              <LabeledList.Item label="Digest Chance">
                <Button
                  content={interacts.digestchance + "%"}
                  onClick={() => act("set_attribute", { attribute: "b_digestchance" })} />
              </LabeledList.Item>
            </LabeledList>
          ) : "These options only display while interactions are turned on."}
        </Section>
      ) || "Error"}
    </Fragment>
  );
};

const VoreContentsPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    show_pictures,
  } = data;
  const {
    contents,
    belly,
    outside = false,
  } = props;

  return (
    <Fragment>
      {outside && (
        <Button
          textAlign="center"
          fluid
          mb={1}
          onClick={() => act("pick_from_outside", { "pickall": true })}>
          All
        </Button>
      ) || null}
      {show_pictures && (
        <Flex wrap="wrap" justify="center" align="center">
          {contents.map(thing => (
            <Flex.Item key={thing.name} basis="33%">
              <Button
                width="64px"
                color={thing.absorbed ? "purple" : stats[thing.stat]}
                style={{
                  'vertical-align': 'middle',
                  'margin-right': '5px',
                  'border-radius': '20px',
                }}
                onClick={() => act(thing.outside ? "pick_from_outside" : "pick_from_inside", {
                  "pick": thing.ref,
                  "belly": belly,
                })}>
                <img
                  src={"data:image/jpeg;base64, " + thing.icon}
                  width="64px"
                  height="64px"
                  style={{
                    '-ms-interpolation-mode': 'nearest-neighbor',
                    'margin-left': '-5px',
                  }} />
              </Button>
              {thing.name}
            </Flex.Item>
          ))}
        </Flex>
      ) || (
        <LabeledList>
          {contents.map(thing => (
            <LabeledList.Item key={thing.ref} label={thing.name}>
              <Button
                fluid
                mt={-1}
                mb={-1}
                color={thing.absorbed ? "purple" : stats[thing.stat]}
                onClick={() => act(thing.outside ? "pick_from_outside" : "pick_from_inside", {
                  "pick": thing.ref,
                  "belly": belly,
                })}>
                Interact
              </Button>
            </LabeledList.Item>
          ))}
        </LabeledList>
      )}
    </Fragment>
  );
};

const VoreUserPreferences = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    allow_dog_borgs, // unused currently
    allow_eat_noises,
    allow_digestion_noises,
    allow_digestion_damage,
    allow_digestion_death,
    allow_absorbtion, // unused currently
    allow_healbelly_healing, // unused currently
    allow_vore_messages,
    allow_death_messages,
    allow_being_prey,
    allow_being_fed_prey,
    allow_seeing_belly_descs,
    allow_trash_messages,
    master_vore_switch,
    allow_being_sniffed, // unused currently

    digestable,
    devourable,
    feeding,
    absorbable,
    allowmobvore,
    vore_sounds,
    digestion_sounds,
    lickable,
    smellable,
  } = data.prefs;

  const {
    show_pictures,
  } = data;

  return (
    <Section title="Preferences" buttons={
      <Button icon="eye" selected={show_pictures} onClick={() => act("show_pictures")}>
        Contents Preference: {show_pictures ? "Show Pictures" : "Show List"}
      </Button>
    }>
      <Flex spacing={1} wrap="wrap" justify="center">

        <Flex.Item basis="99%">
          <Button
            onClick={() => act("master_vore_switch")}
            icon={master_vore_switch ? "toggle-on" : "toggle-off"}
            selected={master_vore_switch}
            fluid
            tooltip={"This button is the master vore preferences switch. If this is off, all vore preferences will be treated as disallowed, "
            + "equivalent to setting all of the rest of the buttons to off. Turning it on won't enable any other preferences, but it will "
            + "permit allowed vore preferences to be checked. "
            + (master_vore_switch
              ? "Click here to disable all vore for you."
              : "Click here to allow certain vore for you.")}
            content={master_vore_switch ? "Master Vore Preference Switch: ON" : "Master Vore Preference Switch: OFF"} />
        </Flex.Item>
        <Flex.Item basis="49.5%">
          <Button
            onClick={() => act("toggle_devour")}
            icon={allow_being_prey ? "toggle-on" : "toggle-off"}
            selected={allow_being_prey}
            fluid
            tooltip={"This button will toggle whether or not you can be prey. This includes being eaten, devoured, or otherwise stuffed into a vorebelly. "
            + (allow_being_prey
              ? "Click here to prevent being prey."
              : "Click here to allow being prey.")}
            content={allow_being_prey ? "You can be prey" : "You can not be prey"} />
        </Flex.Item>
        <Flex.Item basis="49.5%">
          <Button
            onClick={() => act("toggle_feeding")}
            icon={allow_being_fed_prey ? "toggle-on" : "toggle-off"}
            selected={allow_being_fed_prey}
            fluid
            tooltip={"This button will toggle whether or not others can feed you prey. "
            + "This includes things like others climbing into your mouth, someone shoving another person into your bluespace purse, etc. "
            + (allow_being_fed_prey
              ? "Click here to prevent others from feeding you prey."
              : "Click here to allow others to feed you prey.")}
            content={allow_being_fed_prey ? "You can be fed prey" : "You can not be fed prey"} />
        </Flex.Item>

        <Flex.Item basis="49.5%">
          <Button
            onClick={() => act("toggle_digestion_damage")}
            icon={allow_digestion_damage ? "toggle-on" : "toggle-off"}
            selected={allow_digestion_damage}
            fluid
            tooltip={"This button will toggle whether or not digestive bellies will hurt you. "
            + "Do note, this only applies to damage caused by the belly, damage from other sources, including damage transfered from "
            + "damage to whoeverever you're inside. "
            + (allow_digestion_damage
              ? "Click here to prevent being damaged by digestion."
              : "Click here to allow being damaged by digestion.")}
            content={allow_digestion_damage ? "Digestion can hurt you" : "Digestion can not hurt you"} />
        </Flex.Item>
        <Flex.Item basis="49.5%">
          <Button
            onClick={() => act("toggle_digestion_death")}
            icon={allow_digestion_death ? "toggle-on" : "toggle-off"}
            selected={allow_digestion_death}
            fluid
            tooltip={"This button will toggle whether or not digestive bellies will kill you. "
            + "Do note, digestive bellies will still hurt you if you allow damage, just that the damage caused by the belly will not finish you off. "
            + (allow_digestion_death
              ? "Click here to prevent digestion from killing you."
              : "Click here to allow digestion to kill you.")}
            tooltipPosition="bottom-start"
            content={allow_digestion_death ? "Digestion can kill you" : "Digestion can not kill you"} />
        </Flex.Item>

        {/* <Flex.Item basis="25%">
          <Button
            onClick={() => act("toggle_absorbtion")}
            icon={allow_absorbtion ? "toggle-on" : "toggle-off"}
            selected={allow_absorbtion}
            fluid
            tooltip={"This button will toggle whether or not you can be absorbed into someone's vorebelly. "
            + (allow_absorbtion
              ? "Click here to prevent yourself being absorbed."
              : "Click here to allow yourself to be absorbed.")}
            content={allow_absorbtion ? "You can be absorbed" : "You can not be absorbed"} />
        </Flex.Item>
        <Flex.Item basis="25%">
          <Button
            onClick={() => act("toggle_healbelly")}
            icon={allow_healbelly_healing ? "toggle-on" : "toggle-off"}
            selected={allow_healbelly_healing}
            fluid
            tooltip={"This button will toggle whether or not you can be absorbed into someone's vorebelly. "
            + (allow_healbelly_healing
              ? "Click here to prevent yourself being absorbed."
              : "Click here to allow yourself to be absorbed.")}
            content={allow_healbelly_healing ? "You can be absorbed" : "You can not be absorbed"} />
        </Flex.Item> */}

        <Flex.Item basis="49.5%">
          <Button
            onClick={() => act("toggle_eat_noises")}
            icon={allow_eat_noises ? "toggle-on" : "toggle-off"}
            selected={allow_eat_noises}
            fluid
            tooltip={"This button will toggle whether or not you will hear eating sounds. "
            + "Do note, this currently only applies to eating sounds associated with vore. Regular eating sounds are not affected. "
            + (allow_eat_noises
              ? "Click here to make eating silent."
              : "Click here to make eating loud.")}
            tooltipPosition="bottom-start"
            content={allow_eat_noises ? "Eating is loud" : "Eating is quiet"} />
        </Flex.Item>
        <Flex.Item basis="49.5%">
          <Button
            onClick={() => act("toggle_digestion_noises")}
            icon={allow_digestion_noises ? "toggle-on" : "toggle-off"}
            selected={allow_digestion_noises}
            fluid
            tooltip={"This button will toggle whether or not you will hear the sounds associated with being inside of a stomach. "
            + "This mostly includes the squishy-heartbeat sound loop. If you turn this off while you're currently hearing that, "
            + "give it a moment, it should go away on its own."
            + (allow_digestion_noises
              ? "Click here to make wet bellies silent."
              : "Click here to make wet bellies squelchy.")}
            tooltipPosition="bottom-start"
            content={allow_digestion_noises ? "Digestion is loud" : "Digestion is quiet"} />
        </Flex.Item>
        <Flex.Item basis="49.5%">
          <Button
            onClick={() => act("toggle_vore_messages")}
            icon={allow_vore_messages ? "toggle-on" : "toggle-off"}
            selected={allow_vore_messages}
            fluid
            tooltip={"Toggles whether or not you can see vore-related messages. Note this only applies to messages generated by "
            + "the game, anything said by players will still be visible. "
            + (allow_vore_messages
              ? "Click here to turn off seeing vore-related messages."
              : "Click here to turn on seeing vore-related messages.")}
            tooltipPosition="bottom-start"
            content={allow_vore_messages ? "Vore messages: Visible" : "Vore messages: Hidden"} />
        </Flex.Item>
        <Flex.Item basis="49.5%">
          <Button
            onClick={() => act("toggle_death_messages")}
            icon={allow_death_messages ? "toggle-on" : "toggle-off"}
            selected={allow_death_messages}
            fluid
            tooltip={"Toggles whether or not you can see vore-related messages about death. Note this only applies to messages generated by "
            + "the game, anything said by players will still be visible. "
            + (allow_death_messages
              ? "Click here to turn off seeing vore-related death messages."
              : "Click here to turn on seeing vore-related death messages.")}
            tooltipPosition="bottom-start"
            content={allow_death_messages ? "Vore death: Visible" : "Vore death: Hidden"} />
        </Flex.Item>
        <Flex.Item basis="49.5%">
          <Button
            onClick={() => act("toggle_seeing_belly_descs")}
            icon={allow_seeing_belly_descs ? "toggle-on" : "toggle-off"}
            selected={allow_seeing_belly_descs}
            fluid
            tooltip={"Toggles whether or not you can see others' belly descriptions, when visible. "
            + (allow_seeing_belly_descs
              ? "Click here to turn off seeing belly descriptions."
              : "Click here to turn on seeing belly descriptions.")}
            tooltipPosition="bottom-start"
            content={allow_seeing_belly_descs ? "Other bellies: Visible" : "Other bellies: Hidden"} />
        </Flex.Item>
        <Flex.Item basis="49.5%">
          <Button
            onClick={() => act("toggle_seeing_people_spit_up_trash")}
            icon={allow_trash_messages ? "toggle-on" : "toggle-off"}
            selected={allow_trash_messages}
            fluid
            tooltip={"Toggles whether or not you can see when other people spit up trash. "
            + (allow_trash_messages
              ? "Click here to turn off seeing people spit up trash."
              : "Click here to turn on seeing people spit up trash.")}
            tooltipPosition="bottom-start"
            content={allow_trash_messages ? "Trash messages: Visible" : "Trash messages: Hidden"} />
        </Flex.Item>
        <Flex.Item basis="49.5%">
          <Button
            fluid
            content="Set Taste"
            icon="grin-tongue"
            onClick={() => act("setflavor")} />
        </Flex.Item>

        {/* <Flex.Item basis="33%">
          <Button
            onClick={() => act("toggle_smellable")}
            icon={smellable ? "toggle-on" : "toggle-off"}
            selected={smellable}
            fluid
            tooltip={"Toggles whether or not others can smell you. "
            + (smellable
              ? "Click here to turn off being able to be smelled."
              : "Click here to turn on being able to be smelled.")}
            content={smellable ? "You are smellable" : "You are not smellable"} />
        </Flex.Item> */}
        {/* <Flex.Item basis="33%">
          <Button
            fluid
            content="Set Smell"
            icon="wind"
            onClick={() => act("setsmell")} />
        </Flex.Item> */}

      </Flex>
      <Section>
        <Flex spacing={1}>
          <Flex.Item basis="49.5%">
            <Button
              fluid
              content="Save Prefs"
              icon="save"
              onClick={() => act("saveprefs")} />
          </Flex.Item>
          <Flex.Item basis="49.5%" grow={1}>
            <Button
              fluid
              content="Reload Prefs"
              icon="undo"
              onClick={() => act("reloadprefs")} />
          </Flex.Item>
        </Flex>
      </Section>
    </Section>
  );
};
