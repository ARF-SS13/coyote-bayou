import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Button, Flex, Tabs, Section } from '../components';

export const LoadoutSelect = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window width={500} height={450} resizable>
      <Window.Content scrollable>
        <Tabs style={{ "vertical-align": "top", "flex": "initial" }}>
          {!(data.outfits?.length) && "No loadout options." || data.outfits.map(outfit => (
            <Tabs.Tab
              key={outfit}
              selected={data.selected === outfit}
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
              {!data.items?.length && "No outfit selected." || data.items.map(item => (
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
              {!data.preview && "No outfit selected."
              || (
                <div style={{ "text-align": "center" }}>
                  <img src={`data:image/jpeg;base64,${data.preview}`} style={{ "image-rendering": "pixelated", "-ms-interpolation-mode": "nearest-neighbor" }} width={220} height={220} /><br />
                  <br />
                  <Button style={{ "margin": "auto", "display": "block", "text-align": "center" }} content={"Finished"} onClick={() => act('loadout_confirm')} />
                </div>)}
            </Section>
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};
