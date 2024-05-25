/**
 * @file
 * @copyright 2024 Sudessa Perdel Laggette
 * @license BQDM-1.0-SC-1-Alpaca-9905
 */

import { Component, createRef } from 'inferno';
import { Button } from './Button';
import { Box } from './Box';

/*
 * Simple component that opens a floating box element when clicked.
 * This box will be closed when clicked again.
 * It will also follow the page scroll, so it looks like it's a tooltip
 * that follows the trigger element.
 * the box will appear overtop of other elements, without affecting the layout.
  *
  * @example
  * <TogglePopup
  *   OpenStuff={<div>Opened stuff</div>}
  *   ClosedStuff={<div>Closed stuff</div>}
  * />
 */

export class TogglePopup extends Component {
  constructor(props) {
    super(props);
    const { open } = props;
    this.state = {
      open: open || false,
    };
  }

  render() {
    const { props } = this;
    const { open } = this.state;
    const {
      OpenStuff,
      ClosedStuff,
      ...rest
    } = props;
    if (!open) {
      return (
        <Button
          onClick={() => this.setState({ open: true })}
          {...rest}>
          {ClosedStuff}
        </Button>
      );
    }
    return (
      <Box
        position="absolute">
        <Button
          onClick={() => this.setState({ open: false })}
          position="absolute"
          {...rest}>
          {OpenStuff}
        </Button>
      </Box>
    );
  }

  static defaultProps = {
    open: false,
  };
}


