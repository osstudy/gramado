/*
 * File: include\execve\dd\sm\disk\disk.h 
 *
 * Descri��o:
 *     Gerenciador de discos. 
 *     Header para rotinas de opera��o com discos.
 *
 * Obs: 
 *     Part of hal.
 *
 * 2015 - Created by Fred Nora
 * 2018 - IDE controller support by Nelson Cole.
 *
 */
 
 
 
#define DISK_COUNT_MAX 8
#define DISK_BYTES_PER_SECTOR 512 
//#define DISK_BYTES_PER_SECTOR 4096 
 
 
//macro
//#define CYLMAX(c)  ((c) > 1023 ? 1023 : (c))  



/*
 *****************************************************
 * disk_type_t:
 *     Enumerando os tipos de disk.
 *
 */
typedef enum {
	
	DISK_TYPE_NULL,            // Null. 
	
	DISK_TYPE_PATA,
	
	DISK_TYPE_PATAPI,
	
	DISK_TYPE_SATA,
	
	DISK_TYPE_SATAPI
	
}disk_type_t;


 
/*
 * diskinfo_d
 *
 * Disk info struct.
 *
 */ 
struct diskinfo_d
{ 
	object_type_t objectType;
	object_class_t objectClass;  
   
	
	//
	// Disk info.
	//
	
	int id;     
	
	int used;   
	int magic;  
	
	char *name; 
	
	
	//unsigned long flag;  //f
	//unsigned long error; //e
	
    unsigned long BytesPerSector;       //Number of bytes per sector.
    unsigned long SectorsPerCluster;    //Number of sectors per cluster.
	
	
	//
	// MBR info. 
	//
    
    struct mbr_d *mbr;
	struct partition_table_d *PartitionTable; 
    unsigned long PartitionNumber; 	// Partition Number. (Qual das 4 parti��es � a parti��o ativa.)
	unsigned long Signature;     
	
	
	//
	// @todo #bugbug Aqui n�o deve ficar informa��es sobre volumes.
	// talvez um ponteiro para o volume principal e s� isso.
	//
	
	
	
	//
	// Volume list.  x->Volumes[i].xxx
	//
	
	struct volumeinfo_d *Volumes; 
	
	//Navigation.
    //struct diskinfo_d *next;	
};

//diskinfo_t *diskinfo_conductor;
//diskinfo_t *CurrentDiskInfo; 
//diskinfo_t *CurrentDisk;
//diskinfo_t *diskinfo;
//diskinfo_t *SystemDiskInfo;
//...


/*
 * disk_d:
 *     Estrutura para acesso r�pido a discos.
 *     Deve ser simples e com poucos elementos.
 */
struct disk_d
{ 
	object_type_t objectType;
	object_class_t objectClass;
	
	disk_type_t diskType;  // PATA  SATA ...
	
	int id;
	
	int used;
	int magic;
	
	//Ponteiro para o nome do disco,
	//talvez n�o precise ser um ponteiro, pode ser um array.
	char *name;  
	
	
	// informa��es com base na sondagem feita 
	// pelo driver de ide.
	
	//isso ser� v�lido se for um disco do controlador ide.
	//com isso � s� checan na estrutura as informa��es do disco 
	//que est� naquela porta.  ( ide_ports[i].xxx ) ...
	//#importante: checaremos todos os discos instalados,
	//... o bootloader ter� que passar informa��es 
	//sobre o disco que ele fez o boot.
	//pois poderemos encontrar v�rios discos com uma parti��o ativa.
	//mas por enquanto vamos apenas criar uma estrutura de disco para cada 
	//disco encontrado.
	//ent�o devemos seguir a seguinte ordem, primeiro detectamos os discos
	//da interface ide, e depois criamos uma estrutura de disco para 
	//cada disco encontrado.
	//ent�o � na hora que encontramos o disco que inicializamos as estruturas 
	//de disco, sendo assim n�o podemos inicializar estruturas de disco, sem 
	//antes percebermos quais discos est�o instalados.
	
	int current_ide_port;
	

    struct diskinfo_d *disk_info;	
	struct disk_d *next;
};
struct disk_d DISKS[32];


void diskShowCurrentDiskInfo();

int diskShowDiskInfo ( int descriptor );

void *disk_get_disk_handle( int number );
void *disk_get_current_disk_info();
int disk_init();
void init_test_disk();  //*teste de opera��o com disco. 



//
// End.
//

