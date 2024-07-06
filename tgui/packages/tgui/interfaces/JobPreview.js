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
  Icon,
} from '../components';
import { toFixed } from 'common/math';
import {
  formatMoney,
  formatTime,
} from '../format';
import { Window } from '../layouts';
import { multiline } from '../../common/string';

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
  const JobMenuWidth = MenuState === MAIN ? "100%" : "5%";
  const DescriptionWidth = MenuState === MAIN ? "0%" : "95%";
  const JobMenuShrinkfit = MenuState === MAIN ? 0 : 1;


  return (
    <Window
      width={1024}
      height={768}
      resizable
      theme="ntos"
      title="What will you be today?">
      <Window.Content>
        <Box
          width={JobMenuWidth}
          height="100%">
          <JobMenu />
        </Box>
        {MenuState === JDESC ? (
          <Box
            width={DescriptionWidth}
            height="100%">
            <JobDescription />
          </Box>
        ) : null}
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
  const WrapFlex = MenuState === MAIN ? "100%" : "5%";
  const JobsDirection = MenuState === MAIN ? "row" : "column";
  return (
    // <Section
    //   title="Jobs"
    //   height="100%"
    //   scrollable={MenuState === JDESC}
    //   buttons={MenuState === JDESC ? (
    //     <Button // back button, clears MyJobject
    //       icon="arrow-left"
    //       onClick={() => setMyJobject({})} />
    //   ) : null}>
    <Flex
      wrap={WrapFlex}
      direction={JobsDirection}>
      {AllJobsNCats.map((Cat, index) => (
        <Flex.Item key={index}>
          <CatJobList
            key={index}
            Cat={Cat} />
          Box
        </Flex.Item>
      ))}
    </Flex>
    // </Section>
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

  return (
    <Box
      as="fieldset"
      mb={1}
      style={{
        "border": "2px solid " + CatColor,
        "borderRadius": "5px",
      }}>
      <Box
        as="legend"
        color={CatColor}>
        {CatTitle}
      </Box>
      <Stack fill vertical>
        {CatJobs.map((Job, index) => (
          <Stack.Item key={index}>
            <Button
              key={index}
              color={
                Job.Title === MyJobject.Title
                  ? "green"
                  : "default"
              }
              onClick={() => setMyJobject(Job)}>
              <Box
                color={Job.JobColor}>
                {`${Job.Title} [${Job.CurrentPositions}/${Job.TotalPositions}]`}
              </Box>
            </Button>
          </Stack.Item>
        ))}
      </Stack>
    </Box>
  );
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
    CurrencyUnit,
  } = MyJob;

  return (
    <Section
      fill
      title={Title
        + " -- (" + CurrentPositions
        + "/" + TotalPositions + ")"}
      buttons={(
        <JoinButton />
      )}>
      <Stack fill vertical textAlign="left">
        <Stack.Item>
          {ReqType
            && ReqType.length > 1
            && ReqMinutes
            && ReqMinutes.length > 1 ? (
              <Box>
                {"This job requires "
                + ReqMinutes
                + " of playtime as "
                + ReqType
                + " to take!"}
              </Box>
            ) : null}
          <Box width="100%">
            {Description}
          </Box>
          {Extrastuff && Extrastuff.length > 0 ? (
            <Box>
              {Extrastuff}
            </Box>
          ) : null}
        </Stack.Item>
        <Stack.Item>
          <LabeledList>
            <LabeledList.Item label="Supervisor(s)">
              {Supervisors}
            </LabeledList.Item>
            <LabeledList.Item label="Pay Per Hour">
              {Paycheck} {CurrencyUnit}
            </LabeledList.Item>
            {Forbids && Forbids.length > 0 ? (
              <LabeledList.Item label="Forbids">
                {Forbids}
              </LabeledList.Item>
            ) : null}
            {Enforces && Enforces.length > 0 ? (
              <LabeledList.Item label="Enforces">
                {Enforces}
              </LabeledList.Item>
            ) : null}
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
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
  } = data;

  const ButtCantIcon = "times";
  const ButtCanIcon = "user";
  const ButtCantStyle = {
    "color": "black",
  };
  const ButtCanStyle = {
    "color": "#00FF00",
  };

  switch (SpawnFailure) {
    // Can do!
    case 0:
      return (
        <Button
          icon={ButtCanIcon}
          style={ButtCanStyle}
          content="-> Join! <-"
          Tooltip="You can spawn this job!"
          onClick={() => act('JoinJob', {
            MyCkey: data.MyCkey,
            JobTitle: Title,
          })} />
      );
    // generic failure
    case 1:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="Cannot Spawn"
          Tooltip="You cannot spawn this job right now!"
          disabled />
      );
    // job banned
    case 2:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="BANNED"
          Tooltip="You are banned from this job!"
          disabled />
      );
    // Needs more playtime
    case 3:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content={TimeTillCanSpawn}
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
          content="Too New"
          Tooltip="Your account is too new to spawn this job!"
          disabled />
      );
    // Job is full
    case 5:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="Full"
          Tooltip="This job is full!"
          disabled />
      );
      // Species cant join this job (unused)
    case 6:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="Cannot Spawn"
          Tooltip="Your species cannot spawn this job! This feture sucks."
          disabled />
      );
    // Job requires a whitelist
    case 7:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="Whitelist"
          Tooltip="This job requires a whitelist!"
          disabled />
      );
    // User is not in the lobby
    case 8:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="Not in Lobby"
          Tooltip="You are not in the lobby! Go respawn if you want to spawn this job."
          disabled />
      );
    // default
    default:
      return (
        <Button
          icon={ButtCantIcon}
          style={ButtCantStyle}
          content="Cannot Spawn"
          Tooltip="You cannot spawn this job right now!"
          disabled />
      );
  }
};


