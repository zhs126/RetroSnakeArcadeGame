#ifndef SNAKE_H_
#define SNAKE_H_

#define NUM_VGA_COLUMNS   (80)
#define NUM_VGA_ROWS      (40)
#define BORDER '#'
#define FOOD '@'
#define SNAKE 'S'
#define INITIAL_SNAKE_SPEED (2)
#define INITIAL_SNAKE_LENGTH (3)
#define SNAKE_SPEED_INCREASE (1)
#define SNAKE_LENGTH_LIMIT (2048)
#define MILLISECONDS_PER_SEC (1000)
#define VGA_START  0x00700000
#define VGA_CTL     (*(volatile unsigned char *)(0x00700F00))
#define VGA_CRX    (*(volatile unsigned char *)(0x00700F02))
#define VGA_CRY         (*(volatile unsigned char *)(0x00700F04))

/*******************************************************************************************
** Function Prototypes
*******************************************************************************************/

void Wait1s(void);
void putcharxy(int x, int y, char ch);
void print_at_xy(int x,int y, const char* str);
void cls(void);
void gotoxy(int x, int y);
void set_vga_control_reg(char x);
char get_vga_control_reg(void);
void gameOver(void);
void drawRect(int x, int y, int x2, int y2, char ch);
char xtod(int c);
int Get2HexDigits(char *CheckSumPtr);
void updateScore(void);
int clock(void);
void delay_ms(int num_ms);
void initSnake(void);
void drawSnake(void);
void drawFood(void);
void moveSnake(void);
int mod_bld(int x, int y);
void generateFood(void);
int getKeypress(void);
int detectCollision(void);
void mainloop(void);
void snake_main(void);
void snake_game(void);

typedef struct {
    int x;
    int y;
} coord_t;

typedef enum {north, south, west, east} dir_t;


#endif