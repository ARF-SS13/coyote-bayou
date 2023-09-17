/* eslint-disable max-len */
import { useBackend, useLocalState } from "../backend";
import { Box, Button, Flex, Input, Icon, Stack, Dropdown } from "../components";
import { Window } from "../layouts";
import { sanitizeText } from '../sanitize';

export const TraderButton = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Name,
    Locked,
    Deployed,
  } = data;

  const DeployButtText = Deployed ? "Retract" : "Deploy";

  return (
    <Window
      width={300}
      height={400}
      theme="hackerman"
      resizable>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Box
              style={{
                'border-bottom': '1px solid rgba(255, 255, 255, 0.8)',
              }}>
              <Flex>
                <Flex.Item>
                  <Button.Input
                    content={Name}
                    textAlign="left"
                    fontSize="18px"
                    color="white"
                    defaultValue={Name}
                    currentValue={Name}
                    onCommit={() => act("SetName", {"Name" : TrimText(sanitizeText(value), 20)})} />
                </Flex.Item>
                <Flex.Item grow={0} />
                <Flex.Item>
                  <Button
                    content={DeployButtText}
                    selected={Deployed}
                    disabled={Locked && Deployed}
                    onClick={() => act("ToggleDeploy")} />
                </Flex.Item>
              </Flex>
            </Box>
          </Stack.Item>
          <Stack.Item>
            <PassAndLock />
          </Stack.Item>
          <Stack.Item grow={1}>
            <FreqTrans />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const PassAndLock = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Password,
    Locked,
    Deployed,
  } = data;

  if(Locked) {
    return (
      <LockedPass />
    );
  } else {
    return (
      <UnlockedPass />
    );
  }
};

const LockedPass = (props, context) => {
  const { act, data } = useBackend(context);
  const [
    PasswordState,
    setPasswordState,
  ] = useLocalState(context, "PasswordState", "");

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Flex>
          <Flex.Item grow={1}>
            <Input
              placeholder="Whats the password?"
              textAlign="left"
              fontSize="18px"
              color="white"
              onInput={() => TrimText(sanitizeText(value, 8))} />
          </Flex.Item>
          <Flex.Item>
            <Button
              content="Unlock!"
              onClick={() => act("ToggleLock", {"Password" : PasswordState})} />
          </Flex.Item>
        </Flex>
      </Stack.Item>
      <Stack.Item>
        <Box
          textAlign={"center"}>
          <Icon
            name="lock"
            size={3} />
            Secured by GekkerTec Pro
          </Box>
      </Stack.Item>
    </Stack>
  );
};

const UnlockedPass = (props, context) => {
  const { act, data } = useBackend(context);
  const { Password } = data;
  const [
    PasswordState,
    setPasswordState,
  ] = useLocalState(context, "PasswordState", "");

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Flex>
          <Flex.Item grow={1}>
            <Input
              placeholder="Set Password"
              value={Password}
              textAlign="left"
              fontSize="18px"
              color="white"
              onInput={() => TrimText(sanitizeText(value, 8))} />
          </Flex.Item>
          <Flex.Item>
            <Button.Confirm
              content="Set Pass"
              onClick={() => act("SetPassword", {"Password" : PasswordState})} />
          </Flex.Item>
        </Flex>
      </Stack.Item>
      <Stack.Item>
        <Box
          textAlign={"center"}>
          <Button.Confirm
            content="Lock!"
            icon="unlock"
            onClick={() => act("ToggleLock", {"Password" : PasswordState})} />
          </Box>
      </Stack.Item>
    </Stack>
  );
};

const FreqTrans = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Freq,
    MaxFreqLength,
    Password,
    Locked,
    Deployed,
    AllBeepers,
  } = data;

  const [
    FreqState,
    setFreqState,
  ] = useLocalState(context, "FreqState", "Bingus24");

  /// AllBeepers Format:
  /// [
  ///   {
  ///     "Name": "Bingus24",
  ///     "Freq": "Bingus24",
  ///   },
  ///]

  /// An array of beeper data objects
  /// Format:
  /// [
  ///   {
  ///     "Freq": "Bingus24",
  ///     "NumActive": 1,
  ///   },
  ///]
  /// This counts the number of beepers with the same frequency
  const BeeperArray = AllBeepers.map((beeper) => {
    return {
      "Freq": beeper.BeeperFreq,
      "NumActive": AllBeepers.filter((beeper2) => beeper2.BeeperFreq === beeper.BeeperFreq).length,
    };
  });
  /// formats the above into a dropdown-friendly format
  /// Format:
  /// ["Bingus24: 15 Active", "Bingus25: 1 Active"]
  const BeeperDropdown = BeeperArray.map((beeper) => beeper.Freq + ": " + beeper.NumActive + " Active");

  /// The current frequency of the beeper, formatted like the above
  /// Format:
  /// "Bingus24: 15 Active"
  const CurrentFreq = BeeperDropdown.find((entry) => entry.split(":")[0] === Freq);

  /// Converts an entry from the above to just the frequency, to be sent to BYOND
  /// Format:
  /// "Bingus24"
  const BeeperFreq = (entry) => entry.split(":")[0];

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Flex>
          <Flex.Item grow={1}>
            <Input
              placeholder="Set Frequency"
              value={Freq}
              onInput={() => TrimText(sanitizeText(value, 8))} />
          </Flex.Item>
          <Flex.Item>
            <Button
              content="Set Freq"
              onClick={() => act("SetFreq", {"Freq" : FreqState})} />
          </Flex.Item>
        </Flex>
      </Stack.Item>
      <Stack.Item>
        <Dropdown
          options={BeeperDropdown}
          selected={CurrentFreq}
          onSelected={(entry) => act("SetFreq", {"Freq" : BeeperFreq(entry)})} />
      </Stack.Item>
    </Stack>
  );
};

const TrimText = (pass, maxlen) => {
  if(pass.length > maxlen) {
    pass = pass.substring(0, maxlen);
  }
  return pass;
}
