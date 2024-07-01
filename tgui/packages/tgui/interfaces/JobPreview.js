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

// ANATOMY OF AllJobsNCats
// AllJobsNCats = [
//   {
//   "CatColor": "#BADABB",
//   "CatTitle": "Nash Boston Pro Team",
//   "CatJobs": [
//     {
//       "Title": "Head Coach",
//       "Path": "/datum/job/headcoach",
//       "Category": "Nash Boston Pro Team",
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
    MyJob = {},
    MyCkey = "Fooby",
  } = data;

  // checks if MyJob is empty
  const MenuState = Object.keys(MyJob).length === 0 ? "MAIN" : "JOBDESC";
  const JobMenuWidth = MenuState ? "100%" : 0;
  const JobMenuShrinkfit = MenuState ? false : true;


  return (
    <Window
      width={640}
      height={480}
      resizable
      theme="ntos"
      title="What will you be today?">
      <Window.Content>
        <Stack fill>
          <Stack.Item basis={JobMenuWidth} shrink={JobMenuShrinkfit}>
            <JobMenu />
          </Stack.Item>
          {MenuState === "JOBDESC" ? (
            <Stack.Item grow>
              <JobDescription />
            </Stack.Item>
          ) : null}
        </Stack>
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
    MyJob = {},
    MyCkey,
  } = data;

  const MenuState = Object.keys(MyJob).length === 0 ? "MAIN" : "JOBDESC";
  const WrapFlex = MenuState === "MAIN" ? "wrap" : "nowrap";
  const Basisness = MenuState === "MAIN" ? "auto" : "100%";

  return (
    <Section
      title="Jobs"
      fill
      scrollable={MenuState === "MAIN"}
      buttons={MenuState === "JOBDESC" ? (
        <Button
          icon="arrow-left"
          onClick={() => act('ClearJob')} />
      ) : null}>
      <Flex
        wrap={WrapFlex}
        direction="column"
        basis={Basisness}>
        {AllJobsNCats.map((Cat, index) => (
          <Flex.Item key={index}>
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
            <JobButton
              key={index}
              Job={Job} />
          </Stack.Item>
        ))}
      </Stack>
    </Box>
  );
};

// The job button
// A single job button
const JobButton = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Job = {},
  } = props;

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
    JobColor,
    CurrencyUnit,
  } = Job;

  return (
    <Button
      color="transparent"
      onClick={() => act('GetJob', {
        JobTitle: Title,
      })} >
      <Box
        color={JobColor}>
        {`${Title} [${CurrentPositions}/${TotalPositions}]`}
      </Box>
    </Button>
  );
};









// The job description
// Holds the job's description and details
const JobDescription = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    MyJob = {},
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
      title={Title
        + " -- (" + CurrentPositions
        + "/" + TotalPositions + ")"}
      buttons={(
        <JoinButton />
      )}>
      <Stack fill vertical textAlign="left">
        <Stack.Item>
          {ReqType
            && ReqType.length > 0
            && ReqMinutes
            && ReqMinutes.length > 0 ? (
              <Box>
                {"This job requires "
                + ReqMinutes
                + " of playtime as "
                + ReqType
                + " to take!"}
              </Box>
            ) : null}
          <Box>
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


