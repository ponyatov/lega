module ini;

import pegged.grammar;

mixin(grammar(`
    INI:
        syntax  <  (comment/id/any)*
        comment <~ '#'(!'\n'.)*
        id      <~ identifier
        any     <  .
`));
