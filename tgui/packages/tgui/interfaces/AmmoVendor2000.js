/* eslint-disable max-len */
import {
  useBackend,
  useLocalState,
} from '../backend';
import {
  AnimatedNumber,
  Box,
  Button,
  Flex,
  Icon,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
  ToggleBox, // i love togglebox cus I made it
} from '../components';
import { toFixed } from 'common/math';
import {
  formatMoney,
} from '../format';
import { Window } from '../layouts';
import { createSearch } from 'common/string';
import { marked } from 'marked';
import { sanitizeText } from '../sanitize';

const SideButtonWidth = "100px";
const BuyButtonWidth = "100px";
const QBOK = <Box inline backgroundColor="green" color="white">-!!CONNECTED!!-</Box>;
const WindowTitle = "Adventurer's Ammo Supply PRO v0.8β";
const TickOn = <Icon name="toggle-on" color="green" />;
const TickOff = <Icon name="toggle-off" color="label" />;

// Styles
const AmmoEntryOuterStyle = {};

const AmmoDescStyle = {};

const HelloUserStyle = {
  "font-size": "16px",
  "font-weight": "bold",
  "border-bottom": "2px solid rgba(255, 255, 255, 0.5)",
};

const ConnectionOKStyle = {
  "font-size": "12px",
  "font-weight": "bold",
  "border": "2px solid rgba(0, 255, 0, 0.5)",
};

const SideButtonStyle = {};

const EntryHeaderStyle = {
  "font-size": "16px",
  "font-weight": "bold",
  "padding": "0px",
  "margin": "0px",
  "border-bottom": "2px solid rgba(255, 255, 255, 0.5)",
};
const ItemEntryStatsStyle = {
  "font-size": "10px",
  "margin": "0px",
  "padding": "3px",
  "border-bottom": "1px inset rgba(255, 255, 255, 0.5)",
  "line-height": "1.2",
};

const ItemEntryDescStyle = {
  "font-size": "12px",
  "margin": "4px",
  "padding": "4px",
};

const ItemEntryContainerStyle = {
  "border": "3px inset #FFF",
  // "#a4bad6" in rgba, plus 2 shades brighter
  "color": "rgba(194, 226, 244, 1)",
  "background-color": "#223322",
};




/*
 * This is the main window of the AmmoVendor2000 interface. Cool!
 */
export const AmmoVendor2000 = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Window
      width={640}
      height={800}
      title={WindowTitle}
      theme="cardtable"
      resizable>
      <Window.Content
        style={{
          "background-image": "url('../../assets/bg-hornysex.png')",
          "background-size": "fill",
        }}>
        <Stack fill vertical>
          <Stack.Item>
            <TopChunk />
          </Stack.Item>
          <Stack.Item>
            <Flex direction="row">
              <Flex.Item grow>
                <TabQuad />
              </Flex.Item>
              <Flex.Item basis={SideButtonWidth}>
                <Box
                  style={SideButtonStyle}>
                  <Stack fill vertical>
                    <Stack.Item>
                      <BoxToggler />
                    </Stack.Item>
                    <Stack.Item>
                      <CrateToggler />
                    </Stack.Item>
                  </Stack>
                </Box>
              </Flex.Item>
            </Flex>
          </Stack.Item>
          <Stack.Item grow shrink>
            <Section fill scrollable>
              <MainWindow />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <BottomToolbar />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

/*
 * This is the top chunk of the window
 * with the user name and QBank connection status
 * Also contains the currency amount and search bar
 */
const TopChunk = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Username,
    QBcash,
    CurrencyUnit,
    CurrencyName,
    CurrencyPlural,
  } = data;
  const HiThere = `Welcome, ${Username}!`;

  return (
    <Flex direction="row">
      {/* The left chunk, welcome and connection */}
      <Flex.Item grow>
        <Stack fill vertical>
          <Stack.Item>
            <Box
              inline
              fluid
              width="90%"
              style={HelloUserStyle}>
              {HiThere}
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Box
              inline
              style={ConnectionOKStyle}>
              Guild QBank Account Connection:
              {QBOK}
            </Box>
          </Stack.Item>
        </Stack>
      </Flex.Item>
      {/* The right chunk, currency amount and search bar */}
      <Flex.Item basis={SideButtonWidth}>
        <Box
          inline
          width="100%"
          fluid
          style={SideButtonStyle}>
          <Stack fill vertical>
            <Stack.Item>
              <YourCash />
            </Stack.Item>
            <Stack.Item>
              <SearchBox />
            </Stack.Item>
          </Stack>
        </Box>
      </Flex.Item>
    </Flex>
  );
};


/*
 * This is the button that shows the cash!
 */

const YourCash = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Username,
    UserQUID,
    QBcash = 0,
    CurrencyUnit = "₡",
  } = data;

  return (
    <Button
      fluid
      textAlign="center"
      width="100%"
      onClick={() => act('ClickedCashThing', {
        Username: Username,
        UserQUID: UserQUID,
      })} >
      {CurrencyUnit + " "}
      <AnimatedNumber
        initial={0}
        value={QBcash} // we dont do cents here!
        format={value => `${formatMoney(value)}`}
        fontSize="16px"
        fontWeight="bold"
        color="green"
      />
    </Button>
  );
};

/*
 * This is the search box
*/
const SearchBox = (props, context) => {
  const { act, data } = useBackend(context);
  const [
    searchText,
    setSearchText,
  ] = useLocalState(context, 'searchText', '');

  return (
    <Input
      fluid
      value={searchText}
      onInput={(e, value) => setSearchText(value)}
      placeholder="Search for ammo..."
    />
  );
};

/*
 * This is the button that sets Box mode
  */
const BoxToggler = (props, context) => {
  const { act, data } = useBackend(context);

  const [
    CrateMode,
    setCrateMode,
  ] = useLocalState(context, 'CrateMode', false);

  return (
    <Button
      fluid
      onClick={() => {
        setCrateMode(false);
        act('MakeSound', { sound: 'BoxOn' });
      }}>
      <Stack fill>
        <Stack.Item>
          {!CrateMode ? TickOn : TickOff}
        </Stack.Item>
        <Stack.Item>
          <Box inline textAlign="center">
            BOX
          </Box>
        </Stack.Item>
      </Stack>
    </Button>
  );
};

/*
 * This is the button that sets Crate mode
 */
const CrateToggler = (props, context) => {
  const { act, data } = useBackend(context);

  const [
    CrateMode,
    setCrateMode,
  ] = useLocalState(context, 'CrateMode', false);

  return (
    <Button
      fluid
      onClick={() => {
        setCrateMode(true);
        act('MakeSound', { sound: 'CrateOn' });
      }}>
      <Stack fill>
        <Stack.Item>
          {CrateMode ? TickOn : TickOff}
        </Stack.Item>
        <Stack.Item>
          <Box inline textAlign="center">
            CRATE
          </Box>
        </Stack.Item>
      </Stack>
    </Button>
  );
};

// The actual item entry slug
// ANATOMY OF AN ALLITEMS ENTRY:
// {
//   "Category": "Compact Ammo Boxes",
//   "Name": "9mm Box",
//   "Desc": "A box of 9mm ammo. Also theres a heckload of text!",
//   "ShortDesc": "A box of 9mm ammo. Also the...",
//   "RawCost": 152, // in copper
//   "CopperCost": 2,
//   "SilverCost": 5,
//   "GoldCost": 1,
//   "C_M_L_S": "C",
//   "Caliber": "Compact",
//   "KindPath": "/datum/ammo_kind/compact/9mm",
//   "MaxAmmo": 50,
//   "IsCrate": 0,
//   "IsBox": 1,
//   "DamageFlat": 10 OR X, // X is a string, if so, dont display it
//        vv these are sown ONLY IF DamageFlat is NOT a number
//   "DamageMin": 5,
//   "DamageMax": 15,
//   "DamageMean": 10,
//   "DamageMedian": 10,
//   "DamageMode": 10,
//   "DamageVariance": 0,
//   "DamageStdDev": 0,
//   "DamageSkew": 0,
//   "DamageKurtosis": 0,
//   "DamageEntropy": 0
//   "DamageCrit": 20,
//   "DamageCritChance": 0.9%,
// }


/*
 * This is the set of tabs that allow to choose ammo type
 */
const TabQuad = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AmmoTypes,
  } = data;

  const [
    SelectedTab,
    setSelectedTab,
  ] = useLocalState(context, 'SelectedTab', 1);

  // 2x2
  return (
    <Box textAlign="center">
      <Stack fill vertical>
        <Stack.Item>
          <Tabs fluid>
            <Tabs.Tab
              width="50%"
              selected={SelectedTab === 1}
              onClick={() => {
                setSelectedTab(1);
                act('JustUpdate');
              }}>
              Compact Ammo
            </Tabs.Tab>
            <Tabs.Tab
              width="50%"
              selected={SelectedTab === 2}
              onClick={() => {
                setSelectedTab(2);
                act('JustUpdate');
              }}>
              Medium Ammo
            </Tabs.Tab>
          </Tabs>
        </Stack.Item>
        <Stack.Item>
          <Tabs fluid>
            <Tabs.Tab
              width="50%"
              selected={SelectedTab === 3}
              onClick={() => {
                setSelectedTab(3);
                act('JustUpdate');
              }}>
              Long Ammo
            </Tabs.Tab>
            <Tabs.Tab
              width="50%"
              selected={SelectedTab === 4}
              onClick={() => {
                setSelectedTab(4);
                act('JustUpdate');
              }}>
              Shotgun Ammo
            </Tabs.Tab>
          </Tabs>
        </Stack.Item>
      </Stack>
    </Box>
  );
};

/*
 * This is the main window of the AmmoVendor2000 interface.
 */
const MainWindow = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AllItems = [],
    Username,
    UserQUID,
    QBcash,
    CurrencyUnit,
    CurrencyName,
    CurrencyPlural,
  } = data;

  const [
    SelectedTab,
    setSelectedTab,
  ] = useLocalState(context, 'SelectedTab', 1);

  const [
    CrateMode,
    setCrateMode,
  ] = useLocalState(context, 'CrateMode', false);

  const [
    searchText,
    setSearchText,
  ] = useLocalState(context, 'searchText', '');

  // list of entries in the local state that have been clicked to be expanded
  // this is used to keep track of which entries are expanded
  // all without one of my buggy toggleboxes
  const [
    ExpandedEntries,
    setExpandedEntries,
  ] = useLocalState(context, 'ExpandedEntries', []);

  const TrueCategory
    = searchText.length > 0
      ? "Search Results"
      : SelectedTab === 1
        ? CrateMode ? "Compact Ammo Crates" : "Compact Ammo Boxes"
        : SelectedTab === 2
          ? CrateMode ? "Medium Ammo Crates" : "Medium Ammo Boxes"
          : SelectedTab === 3
            ? CrateMode ? "Long Ammo Crates" : "Long Ammo Boxes"
            : SelectedTab === 4
              ? CrateMode ? "Shotgun Ammo Crates" : "Shotgun Ammo Boxes"
              : "EVERYTHING";

  const testSearch = createSearch(searchText, item => {
    return item.Name + item.Desc;
  });

  // if search contains text, filter the list to only show items that match
  // and then filter out any entries that have isCrate set to true if CrateMode is false
  // and vice versa
  // if search does not contain anything, only show entries where
  // Category = TrueCategory
  const EntryList = searchText.length > 0
    ? AllItems
      .filter(testSearch)
      .filter(item => CrateMode ? item.IsCrate : item.IsBox)
    : AllItems
      .filter(item => item.Category === TrueCategory);

  if (EntryList.length === 0) {
    return (
      <NoticeBox>
        {searchText.length === 0
          ? 'No items in this category!'
          : 'No results found.'}
      </NoticeBox>
    );
  }
  return (
    <Box>
      <Box as="h2" textAlign="center">
        {TrueCategory}
      </Box>
      {EntryList.map((item, i) => (
        <Box
          key={i}
          style={ItemEntryContainerStyle}>
          <Stack fill vertical>
            <Stack.Item>
              <Box
                style={EntryHeaderStyle}>
                <Flex direction="row">
                  <Flex.Item grow>
                    <Button
                      width="100%"
                      height="100%"
                      color="transparent"
                      fluid
                      style={{
                        "border": "none",
                        "hover": "none",
                      }}
                      textAlign="left"
                      onClick={() => {
                        if (ExpandedEntries.includes(i)) {
                          setExpandedEntries(ExpandedEntries.filter(e => e !== i));
                        }
                        else {
                          setExpandedEntries([...ExpandedEntries, i]);
                        }
                      }}>
                      {item.Name}
                    </Button>
                  </Flex.Item>
                  <Flex.Item basis={BuyButtonWidth}>
                    <Button
                      icon="shopping-cart"
                      width={BuyButtonWidth}
                      content={
                        `${item.RawCost} ${CurrencyUnit}`
                      }
                      onClick={() => act('PurchaseAmmo', {
                        DesiredAmmoKind: item.KindPath,
                        UserQUID: UserQUID,
                        Username: Username,
                        QBcash: QBcash,
                        RawCost: item.RawCost,
                        CopperCost: item.CopperCost,
                        SilverCost: item.SilverCost,
                        GoldCost: item.GoldCost,
                        CrateOrBox: CrateMode ? "Crate" : "Box",
                      })} />
                  </Flex.Item>
                </Flex>
              </Box>
            </Stack.Item> {/* End of header */}
            <Stack.Item> {/* Statestical stuff */}
              <Box
                style={ItemEntryStatsStyle}>
                {
                  ExpandedEntries.includes(i) ? (
                    <BuildDesc ItemObject={item} />
                  ) : (
                    <BuildDesc Abbreviate ItemObject={item} />
                  )
                }
              </Box>
            </Stack.Item>
            <Stack.Item> {/* Description */}
              <Box
                style={ItemEntryDescStyle}>
                {ExpandedEntries.includes(i) ? item.Desc : item.ShortDesc}
              </Box>
            </Stack.Item>
          </Stack>
        </Box>
      ))}
    </Box>
  );
};


// Closed Description thing
// This is the thing that shows the short description
// and when clicked, expands to show the full description
const BuildDesc = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Abbreviate = false,
    ItemObject = {},
  } = props;

  const {
    Desc,
    ShortDesc,
    Caliber,
    MaxAmmo,
    Crate,
    DamageFlat,
    DamageMin,
    DamageMax,
    DamageMean,
    DamageMedian,
    DamageMode,
    DamageVariance,
    DamageStdDev,
    DamageSkew,
    DamageKurtosis,
    DamageEntropy,
    DamageCrit,
    DamageCritChance,
  } = ItemObject;

  const DescToUse = Abbreviate ? ShortDesc : Desc;

  const AmmoMaxBullets = `Contains ${MaxAmmo} ${Caliber} in a ${Crate ? "crate" : "box"}.`;
  const StatBasis = "20%";

  return (
    <Stack fill vertical>
      <Stack.Item> {/* Ammo Count */}
        {AmmoMaxBullets}
      </Stack.Item>
      <Stack.Item> {/* Damage stuff */}
        {
          isNaN(DamageFlat) ? (
            <Stack fill vertical>
              <Stack.Item>
                {`Damage: ${DamageMin} - ${DamageMax}`}
                {Abbreviate ? (
                  ` (Avg: ${DamageMean})`
                ) : null}
                {!isNaN(DamageCrit) ? (
                  ` (Crit: ${DamageCrit} @ ${DamageCritChance}%)`
                ) : null}
              </Stack.Item>
              {
                Abbreviate ? null : (
                  <Flex direction="row" wrap="wrap" align="baseline">
                    <Flex.Item basis={StatBasis}>
                      {`Mean: ${DamageMean}`}
                    </Flex.Item>
                    <Flex.Item basis={StatBasis}>
                      {`Median: ${DamageMedian}`}
                    </Flex.Item>
                    <Flex.Item basis={StatBasis}>
                      {`Mode: ${DamageMode}`}
                    </Flex.Item>
                    <Flex.Item basis={StatBasis}>
                      {`StdDev: ${DamageStdDev}`}
                    </Flex.Item>
                    <Flex.Item basis={StatBasis}>
                      {`Variance: ${DamageVariance}`}
                    </Flex.Item>
                    <Flex.Item basis={StatBasis}>
                      {`Skew: ${DamageSkew}`}
                    </Flex.Item>
                    <Flex.Item basis={StatBasis}>
                      {`Kurtosis: ${DamageKurtosis}`}
                    </Flex.Item>
                    <Flex.Item basis={StatBasis}>
                      {`Entropy: ${DamageEntropy}`}
                    </Flex.Item>
                  </Flex>
                )
              }
            </Stack>
          ) : (
            `Damage: ${DamageFlat}`
          )
        }
      </Stack.Item>
    </Stack>
  );
};

// The bottom toolbar
// just has a readout of what their weapons can accept
const BottomToolbar = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Username,
    TheirCMLSes,
  } = data;

  if (TheirCMLSes.length === 0) {
    return (
      <Box>
        {`You don't have any weapons that can accept ammo from this vendor! :(`}
      </Box>
    );
  } else {
    return (
      <Box>
        {`You have weapons that can accept: ${TheirCMLSes}`}
      </Box>
    );
  }
};
