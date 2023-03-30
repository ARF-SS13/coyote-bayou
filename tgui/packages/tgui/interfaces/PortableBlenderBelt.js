import { toFixed } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { AnimatedNumber, Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';
import { sortBy } from 'common/collections';

export const PortableBlenderBelt = (props, context) => {
  const { act, data } = useBackend(context);
  const beakerTransferAmounts = data.beakerTransferAmounts || [];
  const chemicals = sortBy(chem => chem.title)(data.chemicals);
  const beakerContents = data.beakerContents || [];
  const bufferVolume = data.bufferVolume || [];
  const bufferMaxVolume = data.bufferMaxVolume || [];
  return (
    <Window
      width={645}
      height={550}
      resizable>
      <Window.Content scrollable>
        <Section
          title="Status"
        >
          <LabeledList>
            <LabeledList.Item label="Buffer Storage">
              <ProgressBar
                value={data.bufferVolume / data.bufferMaxVolume}>
                {toFixed(data.bufferVolume) + 'u / ' + toFixed(data.bufferMaxVolume) + 'u'}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title="Dispense"
          buttons={(
            beakerTransferAmounts.map(amount => (
              <Button
                key={amount}
                icon="plus"
                selected={amount === data.amount}
                content={amount}
                onClick={() => act('amount', {
                  target: amount,
                })} />
            ))
          )}>
          <Box mr={-1}>
            {chemicals.map(chemical => (
              <Button
                key={chemical.id}
                icon="tint"
                width="200px"
                lineHeight="21px"
                content={`${chemical.name} (${chemical.volume}u)`}
                onClick={() => act('dispense', {
                  reagent: chemical.id,
                })} />
            ))}
          </Box>
        </Section>
        <Section
          title="Disposal"
          buttons={
            beakerTransferAmounts.map(amount => (
              <Button
                key={amount}
                icon="minus"
                disabled={false}
                content={amount}
                onClick={() => act('remove', { amount })} />
            ))
          }>
          <Button
            color={data.putItBack ? 'good' : 'bad'}
            icon={data.putItBack ? 'exchange-alt' : 'times'}
            content={data.putItBack ? 'Transfer' : 'Destroy'}
            onClick={() => act('toggle_putback')} />
          <LabeledList>
            <LabeledList.Item
              label="Beaker"
              buttons={!!data.isBeakerLoaded && (
                <Button
                  icon="eject"
                  content="Eject"
                  disabled={!data.isBeakerLoaded}
                  onClick={() => act('eject')} />
              )}>
              {data.isBeakerLoaded
                  && (
                    <Fragment>
                      <AnimatedNumber
                        initial={0}
                        value={data.beakerCurrentVolume} />
                      /{data.beakerMaxVolume} units
                    </Fragment>
                  )
                || 'No beaker'}
            </LabeledList.Item>
            <LabeledList.Item
              label="Contents">
              <Box color="label">
                {!data.isBeakerLoaded && 'N/A'
                  || beakerContents.length === 0 && 'Nothing'}
              </Box>
              {beakerContents.map(chemical => (
                <Box
                  key={chemical.name}
                  color="label">
                  <AnimatedNumber
                    initial={0}
                    value={chemical.volume} />
                  {' '}
                  units of {chemical.name}
                </Box>
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
