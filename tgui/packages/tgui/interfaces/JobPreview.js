/* eslint-disable max-len */
import {
  useBackend,
  useLocalState,
} from '../backend';
import {
  AnimatedNumber,
  Box,
  Button,
  Tooltip,
  Section,
  LabeledList,
  Stack,
  Flex,
  Table,
  Fragment,
  Tabs,
  ToggleBox,
  Icon,
} from '../components';
import { toFixed } from 'common/math';
import {
  formatMoney,
  formatTime,
} from '../format';
import { Window } from '../layouts';
import {
  multiline,
} from '../../common/string';
import { marked } from 'marked';
import { sanitizeText } from '../sanitize';

const MAIN = true;
const JDESC = false;

// ANATOMY OF AllJobsNCats
// AllJobsNCats = [
//   {
//   "CatColor": "#BADABB",
//   "CatTitle": "Nash Boston Pro Team",
//   "CatJobs": [
//     {
//       "Title": "Head Coach",
//       "Path": "/datum/job/headcoach",
//       "Category": "Nash Boston orb meat",
//       "Description": "The head coach kinda blows.",
//       "Supervisors": "Principal Dingus",
//       "Paycheck": 100,
//       "TotalPositions": 1,
//       "SpawnPositions": 1,
//       "CurrentPositions": 0,
//       "Forbids": "dragons",
//       "Enforces": "catboys",
//       "Extrastuff": "This job is really cool.",
//       "HasTimeLock": true,
//       "ReqMinutes": "59 minutes",
//       "ReqType": "Living",
//       "Difficulty": 1,
//       "JobColor": "#FF0000",
//       "CurrencyUnit": "dollars"
//     },
//     and so on...
//  },
//  and so on...
// ]
// ANATOMY OF MyJob
// Its just a job object


export const JobPreview = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AllJobsNCats = [],
    MyCkey = "Fooby",
  } = data;

  const [
    MyJobject,
    setMyJobject,
  ] = useLocalState(context, "MyJobject", {});

  // checks if MyJob is empty
  const MenuState = Object
    .keys(MyJobject)
    .length === 0 ? MAIN : JDESC;
  const JobMenuWidth = MenuState === MAIN ? "100%" : "30%";
  const DescriptionWidth = MenuState === MAIN ? "0%" : "70%";
  const JobMenuShrinkfit = MenuState === MAIN ? 0 : 1;


  return (
    <Window
      width={1124}
      height={768}
      resizable
      theme="cardtable"
      title="What will you be today?">
      <Window.Content
        style={{
          "background-image": "url('https://d.furaffinity.net/art/ecmajor/1717059869/1717059869.ecmajor_clammyenticement2-colofin-web.pngg')",
          "background-size": "cover",
        }}>
        <Flex
          direction="row"
          height="100%">
          <Flex.Item
            basis={JobMenuWidth}
            grow={JobMenuShrinkfit}>
            <JobMenu />
          </Flex.Item>
          {MenuState === JDESC ? (
            <Flex.Item
              basis={DescriptionWidth}
              grow={1}>
              <JobDescription />
            </Flex.Item>
          ) : null}
        </Flex>
        <Button
          icon="rotate"
          content="Refresh"
          onClick={() => act('Refresh')}
          style={{
            "position": "absolute",
            "bottom": "4px",
            "right": "4px",
          }} />

      </Window.Content>
    </Window>
  );
};

// THe job menu! Holds all the categories and jobs
// has two states: MAIN and JOBDESC
// MAIN is the default state, and fills the window with the categories and jobs
// JOBDESC is the state where the user is looking at a job's description
// and the job menu is shrunk to the left and a single column of buttons is dere
// it also makes the list scrollable
const JobMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AllJobsNCats = [],
    MyCkey,
  } = data;

  const [
    MyJobject,
    setMyJobject,
  ] = useLocalState(context, "MyJobject", {});

  const MenuState = Object.keys(MyJobject).length === 0 ? MAIN : JDESC;
  const WrapFlex = MenuState === MAIN ? "wrap" : "nowrap";
  const JobsDirection = MenuState === MAIN ? "row" : "column";
  return (
    <Section
      title="Pick A Role!"
      height="100%"
      // minWidth={0}
      minHeight="100%"
      fill
      scrollable
      buttons={MenuState === JDESC ? (
        <Button // back button, clears MyJobject
          icon="arrow-left"
          onClick={() => setMyJobject({})} />
      ) : null}>
      <Flex
        wrap="wrap"
        align="stretch"
        fill
        justify="flex-start"
        direction={JobsDirection}>
        {AllJobsNCats.map((Cat, index) => (
          <Flex.Item
            grow={1}
            key={index}>
            <CatJobList
              key={index}
              Cat={Cat} />
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};

// The category job list
// Holds the jobs for a single category
const CatJobList = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Cat = {},
  } = props;

  const [
    MyJobject,
    setMyJobject,
  ] = useLocalState(context, "MyJobject", {});

  const {
    CatColor,
    CatTitle,
    CatJobs = [],
  } = Cat;

  const MenuState = Object.keys(MyJobject).length === 0 ? MAIN : JDESC;
  const Duplex = MenuState === MAIN && CatJobs.length > 7 ? true : false;

  return (
    <Box
      as="fieldset"
      mb="4px"
      ml="4px"
      p="4px"
      height="100%"
      backgroundColor="rgba(0, 0, 0, 0.5)"
      style={{
        "border": "2px solid " + CatColor,
        "borderRadius": "5px",
      }}>
      <Box
        as="legend">
        <Box
          width="100%"
          textAlign="center"
          as="h3"
          color={CatColor}>
          {CatTitle}
        </Box>
      </Box>
      <Flex
        wrap={Duplex ? "wrap" : "nowrap"}
        align="stretch"
        fill
        direction={Duplex ? "row" : "column"}
        justify="flex-start">
        {CatJobs.map((Job, index) => (
          <Flex.Item
            key={index}
            shrink={1}
            minWidth={Duplex ? "30%" : "auto"}
            basis={Duplex ? "50%" : "auto"}>
            <Button
              key={index}
              fluid
              color="transparent"
              style={
                Job.Title === MyJobject.Title
                  ? {
                    "border": "1px solid " + CatColor,
                    "borderRadius": "5px",
                  }
                  : ({
                    "border": "1px solid transparent",
                    "borderRadius": "5px",
                  })
              }
              onClick={() => setMyJobject(Job)}>
              <JobLink Job={Job} />
            </Button>
          </Flex.Item>
        ))}
      </Flex>
    </Box>
  );
};

// The job link
// Holds the job's title and color
const JobLink = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Job = {},
  } = props;

  const {
    Title,
    JobColor,
    HasTimeLock,
    ReqType,
    ReqMinutes,
    CurrentMinutes,
    RawTimeLeft,
    TotalPositions,
    CurrentPositions,
    SpawnFailure,
  } = Job;

  if (HasTimeLock && RawTimeLeft > 0) {
    return (
      <Box
        color={JobColor}>
        <Icon
          name="lock"
          color="red" />
        <Tooltip
          content={"This role requires "
            + ReqMinutes
            + " of playtime as "
            + ReqType
            + " to take! You have "
            + CurrentMinutes
            + " of playtime as "
            + ReqType
            + " so far."}>
          {`${Title} [${ReqMinutes}]`}
        </Tooltip>
      </Box>
    );
  } else if (TotalPositions <= 1) { // Infinite positions
    return (
      <Box
        color={JobColor}>
        <Icon
          name="address-card"
          color="green" />
        {Title}
      </Box>
    );
  } else if (CurrentPositions >= TotalPositions) {
    return (
      <Box
        color={JobColor}>
        <Icon
          name="cow"
          color="red" />
        {Title + " [FULL]"}
      </Box>
    );
  } else {
    return (
      <Box
        color={JobColor}>
        <Icon
          name="cat"
          color="green" />
        {Title + " [" + CurrentPositions + "/" + TotalPositions + "]"}
      </Box>
    );
  }
};

// The job description
// Holds the job's description and details
const JobDescription = (props, context) => {
  const { act, data } = useBackend(context);

  const [
    MyJobject,
    setMyJobject,
  ] = useLocalState(context, "MyJobject", {});

  const {
    MyJob = MyJobject,
    MyCkey,
  } = data;

  const {
    Title,
    Description,
    Supervisors,
    Paycheck,
    TotalPositions,
    CurrentPositions,
    Forbids,
    Enforces,
    Extrastuff,
    ReqMinutes,
    ReqType,
    Difficulty,
    JobColor,
    HasTimeLock,
    CurrentMinutes,
    RawTimeLeft,
    CurrencyUnit,
    BriefDescription,
    Lore,
    LoreShort,
    Subordinates,
    OverallResponsibilities,
    SpecificResponsibilities = [],
    DayInTheLife,
    RecommendedSkills = [],
    Focus,
    OOCRules,
    FactionName,
    FactionLeader,
    FactionShortDescription,
    FactionLore,
    FactionVibe,
    FactionGoals,
    FactionRivals,
    FactionAllies,
    FactionPointsOfContention,
  } = MyJobject;

  // skills are formatted as ["Skill Name", "Skill Description", "Skill Name", "Skill Description"]
  // so we need to convert them into objects
  const RecommendedSkillsObjects = [];
  if (RecommendedSkills && RecommendedSkills.length > 0) {
    for (let i = 0; i < RecommendedSkills.length; i += 2) {
      RecommendedSkillsObjects.push([
        RecommendedSkills[i],
        RecommendedSkills[i + 1],
      ]);
    }
  }

  const CellStyle = {
    "border": "1px solid " + JobColor,
    "borderRadius": "5px",
  };

  return (
    <Section
      fill
      minHeight="100%"
      minWidth="100%"
      title={Title}
      scrollable
      width="100%"
      buttons={(
        <JoinButton Job={MyJobject} />
      )}>
      {HasTimeLock && RawTimeLeft > 0
        ? (
          <Box
            textAlign="center"
            m={1}
            p={1}
            style={{
              "border": "1px solid " + JobColor,
              "borderRadius": "5px",
            }}>
            {"This role requires "
            + ReqMinutes
            + " of playtime as "
            + ReqType
            + " to take!"}
            <br />
            {" You have "
            + CurrentMinutes
            + " of playtime as "
            + ReqType
            + " so far."}
            <br />
            {" Keep it up!"}
          </Box>
        ) : null}
      {/* The job specific stuff */}
      <Section
        title="Overview"
        width="100%">
        <CoolBox
          as="h4"
          text={BriefDescription} />
        <CoolBox
          as="p"
          text={Description} />
        {/* Pay */}
        <Box
          textAlign="center"
          m={1}
          p={1}
          style={{
            "border": "1px solid " + JobColor,
            "borderRadius": "5px",
          }}>
          {"Paycheck: "
          + formatMoney(Paycheck) + " " + CurrencyUnit}
        </Box>
        {/* Lorestuffs */}
        {Lore && Lore.length > 0
          ? LoreShort ? (
            <ToggleBox
              OpenStuff={(
                <CoolBox text={Lore} />
              )}
              ClosedStuff={(
                <CoolBox text={LoreShort} />
              )} />
          ) : (
            <CoolBox text={Lore} />
          ) : null}
      </Section>
      {/* Responsibilities */} {/* Specific responsibilities */}
      {OverallResponsibilities && OverallResponsibilities.length > 0
        ? (
          <Section
            title="Responsibilities">
            <CoolBox text={OverallResponsibilities} />
            {SpecificResponsibilities && SpecificResponsibilities.length > 0
              ? (
                <Box>
                  {SpecificResponsibilities.map((Responsibility, index) => (
                    <Box
                      key={index}>
                      &nbsp;&nbsp;
                      <Icon
                        name="angle-right" // mt. Fuzzy
                        color="green" />&nbsp;&nbsp;
                      <Box
                        inline
                        dangerouslySetInnerHTML={{
                          "__html": Responsibility,
                        }}
                      />
                    </Box>
                  ))}
                </Box>
              ) : null}
          </Section>
        ) : null}
      {/* Subs and supers */}
      {Supervisors && Supervisors.length > 0
        ? (
          <Section
            title="Leaders and Bosses">
            <CoolBox text={Supervisors} />
          </Section>
        ) : null}
      {Subordinates && Subordinates.length > 0
        ? (
          <Section
            title="Subjects and Subordinates">
            <CoolBox text={Subordinates} />
          </Section>
        ) : null}
      {/* Forbids and enforces */}
      {Forbids && Forbids.length > 0
        ? (
          <Section
            title="Forbids">
            <CoolBox text={Forbids} />
          </Section>
        ) : null}
      {Enforces && Enforces.length > 0
        ? (
          <Section
            title="Enforces">
            <CoolBox text={Enforces} />
          </Section>
        ) : null}
      {/* Day in the life */}
      {DayInTheLife && DayInTheLife.length > 0
        ? (
          <Section
            title="Day In The Life">
            <CoolBox text={DayInTheLife} />
          </Section>
        ) : null}
      {/* Recommended skills */}
      {RecommendedSkills && RecommendedSkills.length > 0
        ? ( // skill format: ["Skill Name", "Skill Description"]
          <Section
            title="Recommended Skills">
            <Table>
              {RecommendedSkillsObjects.map((Skill, index) => (
                <Table.Row key={index} style={CellStyle}>
                  <Table.Cell
                    bold
                    color="label"
                    collapsing
                    p={1}
                    m={1}
                    width="content">
                    <CoolBox inline text={Skill[0]} />
                  </Table.Cell>
                  <Table.Cell
                    p={1}
                    m={1}>
                    <CoolBox text={Skill[1]} />
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </Section>
        ) : null}
      {/* Difficulty */}
      {Difficulty && Difficulty > 0
        ? (
          <Section
            title="Difficulty">
            <CoolBox text={Difficulty} />
          </Section>
        ) : null}
      {/* Focus */}
      {Focus && Focus.length > 0
        ? (
          <Section
            title="Focus">
            <CoolBox text={Focus} />
          </Section>
        ) : null}
      {/* OOC rules */}
      {OOCRules && OOCRules.length > 0
        ? (
          <Section
            title="OOC Rules">
            <CoolBox text={OOCRules} />
          </Section>
        ) : null}
      {/* Faction stuff */}
      {FactionName && FactionName.length > 0
        ? (
          <Box>
            <Section
              title={"Faction: " + FactionName}>
              {FactionShortDescription && FactionShortDescription.length > 0
                ? (
                  <CoolBox text={FactionShortDescription} />
                ) : null}
              {FactionLeader && FactionLeader.length > 0
                ? (
                  <CoolBox text={FactionLeader} />
                ) : null}
              {FactionLore && FactionLore.length > 0
                ? (
                  <CoolBox text={FactionLore} />
                ) : null}
              {FactionVibe && FactionVibe.length > 0
                ? (
                  <CoolBox text={FactionVibe} />
                ) : null}
              {FactionGoals && FactionGoals.length > 0
                ? (
                  <CoolBox text={FactionGoals} />
                ) : null}
              {FactionRivals && FactionRivals.length > 0
                ? (
                  <CoolBox text={FactionRivals} />
                ) : null}
              {FactionAllies && FactionAllies.length > 0
                ? (
                  <CoolBox text={FactionAllies} />
                ) : null}
              {FactionPointsOfContention && FactionPointsOfContention.length > 0
                ? (
                  <CoolBox text={FactionPointsOfContention} />
                ) : null}
            </Section>
          </Box>
        ) : null}
    </Section>
  );
};

// The cool box
// Formats text to be cool
// mkas a box that is the box spefified in the props
// with text formatted by CoolFormat
// and put in dangerouslySetInnerHTML
const CoolBox = (props, context) => {
  const {
    ...rest
  } = props;
  return (
    <Box
      width="100%"
      {...rest}
      dangerouslySetInnerHTML={{
        "__html": CoolFormat(props.text),
      }} />
  );
};

// formats descriptions to be cool
const CoolFormat = (text) => {
  const SanitizedText = sanitizeText(text);
  const MarkedText = marked(
    SanitizedText,
    {
      smartypants: false,
      gfm: false,
      tables: false,
      sanitize: false,
      breaks: true,
      smartLists: false,
    }
  );
  return SanitizedText;
};

const JoinButton = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Title,
    Description,
    Supervisors,
    Paycheck,
    TotalPositions,
    SpawnPositions,
    CurrentPositions,
    Forbids,
    Enforces,
    Extrastuff,
    ReqMinutes,
    ReqType,
    Difficulty,
    CurrentMinutes,
    CanSpawnAs,
    TimeTillCanSpawn,
    SpawnFailure,
  } = props.Job;
  const {
    CurrentJobTitle,
    IsInGame,
  } = data;

  const ButtCantIcon = "times";
  const ButtCanIcon = "user";
  const ButtCantStyle = {
    "color": "red",
  };
  const ButtCanStyle = {
    "color": "#00FF00",
  };

  if (CurrentJobTitle === Title) {
    return (
      <Box
        textAlign="center"
        m={1}
        p={1}
        style={{
          "border": "1px solid green",
          "borderRadius": "5px",
        }}>
        {"This is your current role!"}
      </Box>
    );
  } else if (IsInGame) {
    return (null);
  }
  switch (SpawnFailure) {
    // generic failure
    case 1:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="CAN'T SPAWN!"
          Tooltip="You cannot spawn this role right now!"
          disabled />
      );
    // job banned
    case 2:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="YOU'RE JOBBANNED!"
          Tooltip="You are banned from this role!"
          disabled />
      );
    // Needs more playtime
    case 3:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content={"TIMELOCKED: " + TimeTillCanSpawn}
          Tooltip={"This role requires "
            + ReqMinutes
            + "playtime as "
            + ReqType
            + " before you can spawn it!"
            + " You have "
            + CurrentMinutes
            + " playtime as "
            + ReqType
            + " so far, and you'll be able to take this role in around "
            + TimeTillCanSpawn
            + "."}
          disabled />
      );
    // Account is too new
    case 4:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="ACCOUNT TOO NEW!"
          Tooltip="Your account is too new to spawn this role!"
          disabled />
      );
    // Job is full
    case 5:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="JOB IS FULL!"
          Tooltip="This role is full!"
          disabled />
      );
      // Species cant join this job (unused)
    case 6:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="BAD SPECIES (THIS FEATURE SUCKS)!"
          Tooltip="Your species cannot spawn this role! This feture sucks."
          disabled />
      );
    // Job requires a whitelist
    case 7:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="WHITELIST NEEDED!"
          Tooltip="This role requires a whitelist!"
          disabled />
      );
    // User is not in the lobby
    case 8:
      return (null);
    // default
    default:
      return (
        <Button
          icon={ButtCanIcon}
          style={ButtCanStyle}
          content="-> Join! <-"
          Tooltip="You can spawn this role!"
          onClick={() => act('JoinJob', {
            MyCkey: data.MyCkey,
            JoinJob: Title,
          })} />
      );
  }
};


