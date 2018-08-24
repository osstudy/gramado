/*
 * File: ide.h
 *
 * Descri��o:
 *     Header para rotinas de hardware para drivers de ide. hdd.
 *
 * //@todo ide struct 
 * 
 * Vers�o 1.0, 2015.
 */


#define IDE_ATA 0
#define IDE_ATAPI 1

#define ATA_MASTER 0
#define ATA_SLAVE 1 
 
 
//#define HDD1_IRQ 14 
//#define HDD2_IRQ 15 


#define IDE_CMD_READ    0x20
#define IDE_CMD_WRITE   0x30
#define IDE_CMD_RDMUL   0xC4
#define IDE_CMD_WRMUL   0xC5
 
unsigned long ide_handler_address;
 

//estrutura para canais da controladora IDE. 
typedef struct ide_channel_d ide_channel_t; 
struct ide_channel_d
{
	int id;
	
	int used;
	int magic;
	
	char name[8];

    //
    // Cada canal vai ter uma porta diferente.
    // ex: canal 0, maste e canal 0 slave tem portas diferentes.	
	
	unsigned short port_base;
	unsigned char interrupt_number;
	
	//@todo: lock stuff.
	
	//@todo: semaphore
	
	//...
};


//estrutura para discos controlados pela controladora ide.
typedef struct ide_disk_d ide_disk_t;
struct ide_disk_d
{
	//id do disco ide.
	int id;
	
	int used;
	int magic;
	
	char name[8];
    
    unsigned short Type;        // 0: ATA, 1:ATAPI.	
	
	//O canal usado pelo disco.
	//pode ser 0 ou 1, master ou slave.
	//ou outroscanais.
	struct ide_channel_d *channel; 

    //@todo: estrutura para parti��es.

    //
	// Podemos ter muitos elementos aqui.
	//
	
};


 
 
// estrutura para configurar a interface IDE. 
typedef struct ide_d ide_t;
struct ide_d
{
	//...
	int dummy;
	//unsigned long ide_handler_address;
};
//ide_t *Ide;



typedef struct hdd_d hdd_t;
struct hdd_d
{
	//...
	int dummy;
	//unsigned long hdd_handler_address;
};
//hdd_t *Hdd;
 

 
void write_lba( unsigned long address, unsigned long lba);    //ide.
void read_lba( unsigned long address, unsigned long lba);     //ide.

void my_read_hd_sector( unsigned long ax, 
                        unsigned long bx, 
						unsigned long cx, 
						unsigned long dx );    //exec.
						
void my_write_hd_sector( unsigned long ax, 
                         unsigned long bx, 
						 unsigned long cx, 
						 unsigned long dx );    //exec.
				
/* 
 * init_hdd:
 *     Inicializa o m�dulo.
 */				
int init_hdd();

//
// End.
//