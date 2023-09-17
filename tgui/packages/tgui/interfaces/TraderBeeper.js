/* eslint-disable max-len */
import { useBackend, useLocalState } from "../backend";
import { Box, Button, Flex, Input, Icon, Stack, Dropdown } from "../components";
import { Window } from "../layouts";
import { sanitizeText } from '../sanitize';

export const TraderBeeper = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Name,
    Active,
  } = data;

  const ActiveButtIcon = Active
    ? <Icon name="power" color="green" />
    : <Icon name="power" color="red" />;

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
                    content={ActiveButtIcon}
                    selected={Active}
                    onClick={() => act("ToggleActive")} />
                </Flex.Item>
              </Flex>
            </Box>
          </Stack.Item>
          <Stack.Item>
            <SoundSettings />
          </Stack.Item>
          <Stack.Item grow={1}>
            <FreqTrans />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const SoundSettings = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AllSounds,
    Volume,
    SoundRange,
    MaxSoundRange,
    CurrentSound,
  } = data;

  /// AllSounds Format:
  /// ["Sound1", "Sound2", "Sound3"]

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Flex>
          <Flex.Item basis="50%">
            Sound:
          </Flex.Item>
          <Flex.Item>
            <Dropdown
              options={AllSounds}
              selected={CurrentSound}
              onSelected={(entry) => act("SetSound", {"Sound" : entry})} />
          </Flex.Item>
        </Flex>
      </Stack.Item>
      <Stack.Item>
        <Flex>
          <Flex.Item basis="50%">
            <Flex>
              <Flex.Item shrink={1}>
                Volume:
              </Flex.Item>
              <Flex.Item grow={1}>
                <Input
                  value={Volume}
                  onChange={() => act("SetVolume", {"Volume" : sanitizeText(value)})} />
              </Flex.Item>
            </Flex>
          </Flex.Item>
          <Flex.Item>
            <Flex>
              <Flex.Item shrink={1}>
                Range:
              </Flex.Item>
              <Flex.Item grow={1}>
                <Input
                  value={SoundRange}
                  onChange={() => act("SetRange", {"Range" : sanitizeText(value)})} />
              </Flex.Item>
            </Flex>
          </Flex.Item>
        </Flex>
      </Stack.Item>
    </Stack>
  );
};

const FreqTrans = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Freq,
    MaxFreqLength,
    AllButtons,
  } = data;

  const [
    FreqState,
    setFreqState,
  ] = useLocalState(context, "FreqState", "Bingus24");

  /// AllButtons Format:
  /// [
  ///   {
  ///     "Name": "Bingus24",
  ///     "Freq": "Bingus24",
  ///   },
  ///]

  /// An array of button data objects
  /// Format:
  /// [
  ///   {
  ///     "Freq": "Bingus24",
  ///     "NumActive": 1,
  ///   },
  ///]
  /// This counts the number of button with the same frequency
  const ButtArray = AllBeepers.map((butt) => {
    return {
      "Freq": butt.ButtFreq,
      "NumActive": AllButtons.filter((butt2) => butt2.ButtFreq === butt.ButtFreq).length,
    };
  });



  /// formats the above into a dropdown-friendly format
  /// Format:
  /// ["Bingus24: 15 Active", "Bingus25: 1 Active"]
  const ButtDropdown = ButtArray.map((butt) => {
    return butt.Freq + ": " + butt.NumActive + " Active";
  });

  /// The current frequency of the beeper, formatted like the above
  /// Format:
  /// "Bingus24: 15 Active"
  const CurrentFreq = ButtDropdown.find((butt) => butt.startsWith(FreqState));

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
          onSelected={(entry) => act("SetFreq", {"Freq" : ButtonFreq(entry)})} />
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
