import { useBackend } from '../backend';
import { Button, LabeledList, Section, ProgressBar, Flex } from '../components';
import { Window } from '../layouts';

export const WeaponInfo = (props, context) => {
  const { act, data } = useBackend(context);
  // Extract `health` and `color` variables from the `data` object.
  const {
    damage_multiplier,
    penetration_multiplier,
    fire_delay,
    burst,
    burst_delay,
    force,
    force_max,
    armor_penetration,
    recoil_info,
    total_recoil,
    firemode_info,
    attachments,
    caliber,
    current_ammo,
    max_shells,
    charge_cost,
    cell_charge,
    shots_remaining,
    max_shots,
    projectile_name,
    projectile_damage,
    projectile_AP,
    projectile_recoil,
    firemode_count,
  } = data;
  return (
    <Window
      width={550}
      height={700}
      resizable>
      <Window.Content scrollable>
        <Section title="Weapon details:">
          <LabeledList>
            <LabeledList.Item label="Projectile damage multiplier">
              {data.damage_multiplier}x
            </LabeledList.Item>
            <LabeledList.Item label="Fire delay">
              {data.fire_delay} ms
            </LabeledList.Item>
            {data.burst > 1 && (
              <LabeledList.Item label="Rounds per burst">
                {data.burst} rounds
              </LabeledList.Item>
            )}
            {data.burst > 1 && (
              <LabeledList.Item label="Burst delay">
                {data.burst_delay} ms
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
        <Section title="Recoil details:">
          {data.recoil_info.length > 0 ? (
            <LabeledList>
              {data.recoil_info.map(recoilvalue => (
                <LabeledList.Item label={recoilvalue.name}
                  key={recoilvalue.name}>
                  <ProgressBar
                    value={recoilvalue.value}
                    maxValue={data.total_recoil}
                    ranges={{
                      good: [-Infinity, 0.5],
                      average: [0.5, 1.5],
                      bad: [1.5, Infinity],
                    }}>
                    {recoilvalue.value}
                  </ProgressBar>
                </LabeledList.Item>
              ))}
            </LabeledList>
          ) : (
            "Has no kickback."
          )}
        </Section>
        <Section title="Physical details:">
          <LabeledList>
            <LabeledList.Item label="Melee capabilities">
              <ProgressBar
                value={data.force}
                maxValue={data.force_max}
                ranges={{
                  good: [-Infinity, Infinity],
                }}>
                {data.force}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Armor penetration">
              <ProgressBar
                value={data.armor_penetration}
                maxValue={100}
                ranges={{
                  good: [-Infinity, Infinity],
                }}>
                {data.armor_penetration + '%'}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {data.caliber && (
          <Section title="Ammo details:">
            <LabeledList>
              <LabeledList.Item label="Rifled caliber">
                {data.caliber}
              </LabeledList.Item>
              <LabeledList.Item label="Ammo remaining">
                <ProgressBar
                  value={data.current_ammo}
                  maxValue={data.max_shells}
                  ranges={{
                    good: [-Infinity, Infinity],
                  }}>
                  {data.current_ammo}
                </ProgressBar>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
        {data.charge_cost && (
          <Section title="Power information:">
            <LabeledList>
              {data.cell_charge ? (
                <LabeledList.Item label="Cell rating">
                  <ProgressBar
                    value={data.cell_charge}
                    maxValue={100}
                    ranges={{
                      bad: [-Infinity, 33],
                      average: [33, 66],
                      good: [66, Infinity],
                    }} />
                </LabeledList.Item>
              ) : (
                'No cell installed.'
              )}
              <LabeledList.Item label="Power usage">
                {data.charge_cost}
              </LabeledList.Item>
              <LabeledList.Item label="Shots remaining">
                <ProgressBar
                  value={data.shots_remaining}
                  maxValue={data.max_shots}
                  ranges={{
                    bad: [-Infinity, 33],
                    average: [33, 66],
                    good: [66, Infinity],
                  }}>
                  {data.shots_remaining}
                </ProgressBar>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
        {data.projectile_name && (
          <Section title="Projectile info:">
            <LabeledList>
              <LabeledList.Item label="Name">
                {data.projectile_name}
              </LabeledList.Item>
              <LabeledList.Item label="Overall damage">
                {data.projectile_damage}
              </LabeledList.Item>
              <LabeledList.Item label="Overall AP">
                {data.projectile_AP}
              </LabeledList.Item>
              <LabeledList.Item label="Recoil multiplier">
                {data.projectile_recoil}x
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
        {data.firemode_count && (
          <Section title="Firemodes:">
            {data.firemode_info.map(firemodevalue => (
              <Flex key={firemodevalue.index}>
                <Flex.Item grow="0" basis="20%">
                  <Button
                    content={firemodevalue.name}
                    color={firemodevalue.current ? ('red') : (null)}
                    onClick={firemodevalue.current ? (null) : (() => act('firemode', {
                      firemode: firemodevalue.index,
                    }))} />
                </Flex.Item>
                <Flex.Item grow="1" basis="auto">
                  {firemodevalue.desc}
                </Flex.Item>
              </Flex>
            ))}
          </Section>
        )}
        {data.attachments.length > 0 && (
          <Section title="Attachments:">
            <LabeledList>
              {data.attachments.map(attachmentvalue => (
                <LabeledList.Item key={attachmentvalue.name}
                  label={attachmentvalue.name}>
                  {attachmentvalue.desc}
                  <LabeledList.Divider />
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
