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
import { multiline } from '../../common/string';

const SideButtonWidth = "100px";
const QBOK = <Box inline backgroundColor="green" color="white">OK</Box>;
const WindowTitle = "Adventurer's Ammo Supply PRO v0.8β";
const TickOn = <Icon name="toggle-on" color="green" />;
const TickOff = <Icon name="toggle-off" color="label" />;

/*
 * This is the main window of the AmmoVendor2000 interface. Cool!
 */
export const AmmoVendor2000 = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    Username,
    QBcash,
    CurrencyUnit,
    CurrencyName,
    CurrencyPlural,
  } = data;

  // Which ammo type is choosen for to be bought
  const [
    SelectedTab,
    setSelectedTab,
  ] = useLocalState(context, 'SelectedTab', 1);

  // Are we buying a crate, or a box?
  const [
    CrateMode,
    setCrateMode,
  ] = useLocalState(context, 'CrateMode', false);

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
                  style={{
                    "background-color": "label",
                    "border-radius": "5px",
                  }}>
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
            {/* <BottomToolbar /> */}
            <Box />
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
  const QBConn = `Guild QBank Account Connection: ${QBOK}`;

  return (
    <Flex direction="row">
      {/* The left chunk, welcome and connection */}
      <Flex.Item grow>
        <Stack fill vertical>
          <Stack.Item>
            <Box
              inline
              style={{
                "font-size": "20px",
                "font-weight": "bold",
                "color": "white",
              }}>
              {HiThere}
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Box
              inline
              style={{
                "font-size": "16px",
                "color": "label",
              }}>
              {QBConn}
            </Box>
          </Stack.Item>
        </Stack>
      </Flex.Item>
      {/* The right chunk, currency amount and search bar */}
      <Flex.Item basis={SideButtonWidth}>
        <Box
          inline
          style={{
            "background-color": "label",
            "border-radius": "5px",
          }}>
          <Stack fill vertical>
            <Stack.Item>
              <Button
                fluid
                color="green"
                style={{
                  "border-radius": "5px",
                }}>
                <YourCash />
              </Button>
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
    <Box>
      <Stack fill vertical>
        <Stack.Item>
          <Tabs fluid>
            <Tabs.Tab
              selected={SelectedTab === 1}
              onClick={() => {
                setSelectedTab(1);
                act('JustUpdate');
              }}>
              Compact Ammo
            </Tabs.Tab>
            <Tabs.Tab
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
              selected={SelectedTab === 3}
              onClick={() => {
                setSelectedTab(3);
                act('JustUpdate');
              }}>
              Long Ammo
            </Tabs.Tab>
            <Tabs.Tab
              textAlign="center"
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

  const EntryList = AllItems.filter(item => {
    return item.Category === TrueCategory
      || (searchText.length > 0 && testSearch(item));
  });

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
    <Stack fill vertical>
      <Stack.Item>
        <Box as="h2" textAlign="center">
          {TrueCategory}
        </Box>
      </Stack.Item>
      {EntryList.map((item, i) => (
        <Stack.Item key={i}>
          <ItemEntry
            item={item} />
        </Stack.Item>
      ))}
    </Stack>
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
//   "Crate": false,
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
// }
const ItemEntry = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    item = {},
  } = props;

  const {
    Name,
    Desc,
    ShortDesc,
    RawCost,
    CopperCost,
    SilverCost,
    GoldCost,
    C_M_L_S,
    Caliber,
    KindPath,
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
  } = item;

  const [
    CrateMode,
    setCrateMode,
  ] = useLocalState(context, 'CrateMode', false);

  const {
    Username,
    UserQUID,
    QBcash,
    CurrencyUnit,
    CurrencyName,
    CurrencyPlural,
  } = data;

  // theres two parts of this: the header and the body
  // header has the name, the cost, and the buy button (which has the cost)
  // body has a bunch of stuff innit
  // - the max bullets in the box/crate
  // - the caliber (compact, medium, long, shotgun)
  // - the short desc
  // when you click the desc, it expands to show the full desc
  // the full desc when clicked again hides that stuff
  // the toggled stuff is a togglebox, which I made, cus im cool

  const ShortDamageReadout = () => {
    if (typeof DamageFlat === "number") {
      return (
        <Box>
          {`Damage: ${DamageFlat}`}
        </Box>
      );
    } else {
      return (
        <Box>
          {`Damage: ${DamageMin} - ${DamageMax} (Avg: ${DamageMean})`}
        </Box>
      );
    }
  };
  const DamageReadout = () => {
    if (typeof DamageFlat === "number") {
      return (
        <Box>
          {`Damage: ${DamageFlat}`}
        </Box>
      );
    } else {
      // showtime! lets generate all sorts of BS statestical nonsense
      let DamageStats = [];
      if (DamageMin !== DamageMax) {
        DamageStats.push(`Damage: ${DamageMin} - ${DamageMax}`);
      } else {
        DamageStats.push(`Damage: ${DamageMin}`);
      }
      // the (mean, median, mode) trio, format: (Avg: 10, Med: 10, Mod: 10)
      DamageStats.push(`(
        Avg: ${toFixed(DamageMean, 1)},
        Med: ${toFixed(DamageMedian, 1)},
        Mod: ${toFixed(DamageMode, 1)}
      )`);
      // the (variance, std dev, skew, kurtosis, entropy) quintet
      // format: (Var: 0, StdDev: 0, Skew: 0, Kurt: 0, Ent: 0)
      DamageStats.push(`(
        Var: ${toFixed(DamageVariance, 1)},
        1SD: ${toFixed(DamageStdDev, 1)},
        Skew: ${toFixed(DamageSkew, 1)},
        Kurt: ${toFixed(DamageKurtosis, 1)},
        Ent: ${toFixed(DamageEntropy, 1)}
      )`);
      return (
        <Box>
          {DamageStats.map((stat, i) => (
            <Box key={i}>
              {stat}
            </Box>
          ))}
        </Box>
      );
    }
  };
  const cuteString = `${CurrencyUnit} ${RawCost}`;
  const ammoMaxBullets = `Contains ${MaxAmmo} rounds of ${Caliber} ammo in a ${Crate ? "crate" : "box"}.`;
  const closedDesc = () => (
    <Box>
      <Box>
        {ammoMaxBullets}
      </Box>
      <Box>
        {ShortDamageReadout()}
      </Box>
      <Box>
        {ShortDesc}
      </Box>
    </Box>
  );
  const openedDesc = () => (
    <Box>
      <Box>
        {ammoMaxBullets}
      </Box>
      <Box>
        {DamageReadout()}
      </Box>
      <Box>
        {Desc}
      </Box>
    </Box>
  );

  return (
    <Box
      style={{
        "background-color": "black",
        "border-radius": "5px",
        "padding": "2px",
        "margin": "2px",
      }}>
      <Section
        title={Name}
        buttons={(
          <Button
            icon="shopping-cart"
            content={cuteString}
            onClick={() => act('PurchaseAmmo', {
              DesiredAmmoKind: KindPath,
              UserQUID: UserQUID,
              Username: Username,
              QBcash: QBcash,
              RawCost: RawCost,
              CopperCost: CopperCost,
              SilverCost: SilverCost,
              GoldCost: GoldCost,
              CrateOrBox: CrateMode ? "Crate" : "Box",
            })} />
        )}>
        {/* <ToggleBox
          OpenStuff={openedDesc}
          ClosedStuff={closedDesc} /> */}
      </Section>
    </Box>
  );
};
// Proc that sifts through the massive AllItems list and returns a filtered list
// based on the search text, selected tab and crate mode
// Search text is applied to Name and Desc
// Selected tab is applied to Category








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
