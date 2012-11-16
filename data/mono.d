/* 
 * mono.d: DTrace provider for Mono
 * 
 * Authors:
 *   Andreas Faerber <andreas.faerber@web.de>
 * 
 */

provider mono {
	/* Virtual Execution System (VES) */
	probe ves__init__begin ();
	probe ves__init__end ();

	/* Just-in-time compiler (JIT) */
	probe method__compile__begin (char* class_name, char* method_name, char* signature);
	probe method__compile__end (char* class_name, char* method_name, char* signature, int success);

	/* Garbage Collector (GC) */	
	probe gc__begin (int generation);
	probe gc__end (int generation);

	probe gc__concurrent__start__begin (int generation);
	probe gc__concurrent__start__end (int generation);
	probe gc__concurrent__update__finish__begin (int generation);
	probe gc__concurrent__update__end (int generation);
	probe gc__concurrent__finish__end (int generation);

	probe gc__sweep__begin (int generation, int full_sweep);
	probe gc__sweep__end (int generation, int full_sweep);

	probe gc__world__stop__begin ();
	probe gc__world__stop__end ();
	probe gc__world__restart__begin (int generation);
	probe gc__world__restart__end (int generation);

	probe gc__heap__alloc (uintptr_t addr, uintptr_t len);
	probe gc__heap__free (uintptr_t addr, uintptr_t len);

	probe gc__locked ();
	probe gc__unlocked ();

	probe gc__nursery__tlab__alloc (uintptr_t addr, uintptr_t len);
	probe gc__nursery__obj__alloc (uintptr_t addr, uintptr_t size, char *ns_name, char *class_name);

	probe gc__major__obj__alloc__large (uintptr_t addr, uintptr_t size, char *ns_name, char *class_name);
	probe gc__major__obj__alloc__pinned (uintptr_t addr, uintptr_t size, char *ns_name, char *class_name);
	probe gc__major__obj__alloc__degraded (uintptr_t addr, uintptr_t size, char *ns_name, char *class_name);
	probe gc__major__obj__alloc__mature (uintptr_t addr, uintptr_t size, char *ns_name, char *class_name);

	/* Can be nursery->nursery, nursery->major or major->major */
	probe gc__obj__moved (uintptr_t dest, uintptr_t src, int dest_gen, int src_gen, uintptr_t size, char *ns_name, char *class_name);

	probe gc__nursery__swept (uintptr_t addr, uintptr_t len);
	probe gc__major__swept (uintptr_t addr, uintptr_t len);

	probe gc__obj__pinned (uintptr_t addr, uintptr_t size, char *ns_name, char *class_name, int generation);
};

#pragma D attributes Evolving/Evolving/Common provider mono provider
#pragma D attributes Private/Private/Unknown provider mono module
#pragma D attributes Private/Private/Unknown provider mono function
#pragma D attributes Evolving/Evolving/Common provider mono name
#pragma D attributes Evolving/Evolving/Common provider mono args

