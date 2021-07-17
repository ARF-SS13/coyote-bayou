import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Button, Flex, Tabs, Section } from '../components';

export const LoadoutSelect = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    outfits,
    selected,
    items,
    preview,
  } = data;
  return (
    <Window width={500} height={450}>
      <Window.Content scrollable>
        <Tabs style={{ "vertical-align": "top", "flex": "initial" }}>
          {!(outfits?.length) && "No loadout options." || outfits.map(outfit => (
            <Tabs.Tab
              key={outfit}
              selected={selected === outfit}
              onClick={() => act('loadout_select', {
                name: outfit,
              })}>
              {outfit}
            </Tabs.Tab>
          ))}
        </Tabs>
        <Flex direction="row" width="100%">
          <Flex.Item width="50%" height="100%" style={{ "vertical-align": "top" }}>
            <Section title="Contents" fill fitted>
              {!items?.length && "No outfit selected." || items.map(item => (
                <div style={{ "margin": "10px 10px", "text-align": "center" }} key={`${item.name}`}>
                  <div style={{ "transform": "scale(1.5)", "vertical-align": "middle", "float": "left", "clear": "left", "height": "32px", "width": "32px" }} class={item.icon} />
                  <div style={{ "display": "block", "vertical-align": "middle", "float": "left", "width": "calc(100% - 32px)", "line-height": "32px", "margin": "auto" }}>
                    {item.name} {item.quantity > 1
                    && (`x${item.quantity}`)}<br />
                  </div>
                </div>))}
            </Section>
          </Flex.Item>
          <Flex.Item height="100%" width="50%" style={{ "vertical-align": "top" }}>
            <Section title="Preview" fill>
              {!preview && "No outfit selected."
              || (
                <div style={{ "text-align": "center" }}>
                  <img src={`data:image/jpeg;base64,${preview}`} style={{ "image-rendering": "pixelated", "-ms-interpolation-mode": "nearest-neighbor" }} width={220} height={220} /><br />
                  <br />
                  <div style={{ "display": "table", "width": "100%", "text-align": "center" }}>
                    <Button style={{ "display": "table-cell", "text-align": "center" }} content={"<<"} onClick={() => act('loadout_preview_direction', { direction: -1 })} />
                    <Button style={{ "display": "table-cell", "text-align": "center" }} content={">>"} onClick={() => act('loadout_preview_direction', { direction: 1 })} />
                  </div>
                  <Button style={{ "margin": "auto", "display": "block", "text-align": "center" }} content={"Finished"} onClick={() => act('loadout_confirm')} />
                </div>)}
            </Section>
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};
