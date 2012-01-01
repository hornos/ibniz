#include <stdint.h>

#ifdef IBNIZ_MAIN
#  define GLOBAL
#else
#  define GLOBAL extern
#endif

#include "vm.h"

/* i/o stuff used by vm */

uint32_t gettimevalue();
int getuserchar();
void waitfortimechange();

/* vm-specific */

void vm_compile(char*src);
void vm_init();
void vm_run();
void switchmediacontext();

GLOBAL char*clipboard;
void clipboard_load();
void clipboard_store();

#if defined(WIN32)
#define  CLIPBOARD_WIN32
#elif defined(X11)
#define  CLIPBOARD_X11
#include <SDL/SDL.h>
void clipboard_handlesysreq(SDL_Event*e);
#else
#define  CLIPBOARD_NONE
#endif
