/* eslint-disable max-len */
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from "../backend";
import { Box, Button, Flex, Icon, LabeledList, NoticeBox, Section, Table } from "../components";
import { Window } from "../layouts";
const CoolHeaderColor = 'blue';
const CoolFooterColor = 'blue';
const CoolContentColor = "primary";
const CoolButtonboxWidth = "10em";
const CoolHeadfootHeight = "3em";
/**
 * There are three parts to the COOLBOOK, from top to bottom:
 * 1 - The top bar, which contains the return button, the title, and some page navigation buttons.
 * 2 - The content itself, just a big box with a bunch of text.
 * 3 - The bottom bar, which is basically the top, but at the bottom.
 */
export const CoolBook = (props, context) => {
  const { act, data } = useBackend(context);
  const{
    PageText,
    IsIndex,
  } = data;

  return (
    <Window width={400} height={500} resizable>
      <Window.Content>
        <Section
          width="100%"
          height="100%">
          <Flex
            direction="column">
            <Flex.Item

              textAlign="center">
              <CoolBookHead />
            </Flex.Item>
            <Flex.Item
              color={CoolContentColor}>
              <Section
                scrollable
                fluid
                my="auto"
                color={CoolContentColor}>
                {PageText}
                {!!IsIndex && (<CoolBookTableOfContents />)}
              </Section>
            </Flex.Item>
          </Flex>
        </Section>
        <CoolBookFoot />
      </Window.Content>
    </Window>
  );
};

// The Table of Contents, which is only shown on the index page
const CoolBookTableOfContents = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    AllChapters,
  } = data;

  return (
    <Fragment>
      <Section title="Table of Contents">
        <Box color="blue">
          <Flex
            direction="column">
            {AllChapters.map((chapter) => (
              <Flex.Item grow={1}>
                <Button
                  icon="fa-solid fa-book"
                  content={chapter}
                  onClick={() => act("SetChapter", { Chapter2Set: chapter })}/>
              </Flex.Item>
            ))}
          </Flex>
        </Box>
      </Section>
    </Fragment>
  );
};

// The top bar, which contains the return button and the chapter title
const CoolBookHead = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    IsIndex,
  } = data;

  return (
    <Fragment>
      <Section
        width="100%"
        height={CoolHeadfootHeight}
        color={CoolHeaderColor}>
        <Flex>
          <Flex.Item grow={1}>
            <Box
              color={CoolHeaderColor}
              textAlign="center"
              mb={1}>
              {!!IsIndex
                ? <CoolBookIndexTitle />
                : <CoolBookPageTitle />}
            </Box>
          </Flex.Item>
          <Flex.Item basis={CoolButtonboxWidth}>
            <Box
              height="fit-content"
              width="fit-content">
              <Button
                icon="arrow-left"
                content="Return"
                disabled={IsIndex}
                onClick={() => act("SetChapter", { Chapter2Set: "index" })}>
              </Button>
            </Box>
          </Flex.Item>
        </Flex>
      </Section>
    </Fragment>
  );
};

// The text of the title for the index page
const CoolBookIndexTitle = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    BookTitle,
    BookAuthor,
  } = data;

  return (
    <Fragment>
      <Box
        color={CoolHeaderColor}
        textAlign="center"
        mb={1}>
        <Icon name="fa-solid fa-book" /> {BookTitle} <br/>
        <Icon name="fa-solid fa-user" /> {BookAuthor}
      </Box>
    </Fragment>
  );
};
// The text of the title for the non-index page
const CoolBookPageTitle = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    CurrentChapterTitle,
  } = data;

  return (
    <Fragment>
      <Box
        color={CoolHeaderColor}
        textAlign="center"
        mb={1}>
        <Icon name="fa-solid fa-book" /> {CurrentChapterTitle}
      </Box>
    </Fragment>
  );
};

// The bottom bar, which contains the author's name and the page selectors
const CoolBookFoot = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    BookAuthor,
  } = data;

  return (
    <Fragment>
      <Section
        position="fixed"
        bottom={0}
        width="100%"
        height="auto">
        <Box
          height={CoolHeadfootHeight}
          mt="auto">
          <Flex>
            <Flex.Item grow={1}>
              <Box
                align="center"
                m={1}>
                <Icon name="fa-solid fa-trademark" /> {BookAuthor} 20X6
              </Box>
            </Flex.Item>
            <Flex.Item basis={CoolButtonboxWidth}>
              <Box
                align="right"
                height="fit-content"
                width="fit-content">
                <CoolBookPageSelector/>
              </Box>
            </Flex.Item>
          </Flex>
        </Box>
      </Section>
    </Fragment>
  );
};

// The page selectors, which are just two buttons that go to the next or previous page.
// Also displays the current page number and the total number of pages.
const CoolBookPageSelector = (props, context) => {
  const { act, data } = useBackend(context);
  const{
    PageNumber,
    PageTotal,
    CanNext,
    CanPrev,
  } = data;

  return (
    <Fragment>
      <Section mx="5px">
        <Box
          inline
          align="center">
          <Button
            height="fit-content"
            textAlign="center"
            icon="arrow-left"
          //disabled={!CanPrev}
            onClick={() => act("PrevPage")}>
          </Button>
        </Box>
        <Box
          mx="5px"
          inline
          color='blue'
          align="center">
            PAGE<br></br>
            {PageNumber} / {PageTotal}
        </Box>
        <Box
          inline
          align="center">
          <Button
            height="fit-content"
            textAlign="center"
            icon="arrow-right"
            //disabled={!CanNext}
            onClick={() => act("NextPage")}>
          </Button>
        </Box>
      </Section>
    </Fragment>
  );
};
