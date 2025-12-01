--
-- PostgreSQL database dump
--

\restrict qCB2ZDaKbLN3vzc4geTc5H5A9RLhWuDBZzveYxzASf2229SsAiG27jO7xgN1PuN

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    internal_name character varying(100),
    prototype_type character varying(50),
    description text,
    stack_size integer,
    crafting_time double precision,
    image_filename character varying(100),
    produced_by json
);


ALTER TABLE public.items OWNER TO postgres;

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.items_id_seq OWNER TO postgres;

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.items_id_seq OWNED BY public.items.id;


--
-- Name: recipe_ingredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipe_ingredients (
    id integer NOT NULL,
    product_id integer NOT NULL,
    ingredient_id integer NOT NULL,
    amount double precision
);


ALTER TABLE public.recipe_ingredients OWNER TO postgres;

--
-- Name: recipe_ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recipe_ingredients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recipe_ingredients_id_seq OWNER TO postgres;

--
-- Name: recipe_ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recipe_ingredients_id_seq OWNED BY public.recipe_ingredients.id;


--
-- Name: items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items ALTER COLUMN id SET DEFAULT nextval('public.items_id_seq'::regclass);


--
-- Name: recipe_ingredients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients ALTER COLUMN id SET DEFAULT nextval('public.recipe_ingredients_id_seq'::regclass);


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items (id, name, internal_name, prototype_type, description, stack_size, crafting_time, image_filename, produced_by) FROM stdin;
2	Wooden chest	wooden-chest	logistics	Wooden chests are the first type of chest available to the player at the start of the game. They are, like any other means of storage, used for storing items at a fixed position and can be connected to the circuit network to provide their contents as a signal.	50	0.5	Wooden_chest.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3"]
3	Iron ore	iron-ore	items	Iron ore is a resource found on the map. It can be smelted into iron plates in a furnace, and is also a component in concrete.	50	1	Iron_ore.png	["Burner mining drill", "Electric mining drill", "Player"]
4	Iron plate	iron-plate	items	The iron plate is a material that can be made by smelting iron ore in a furnace. It is a component or subcomponent of almost every item in Factorio, and it is recommended to create a large stockpile when possible. When smelted in a furnace for a second time, iron plates will transform into steel plates, with a ratio of 5 iron plates per 1 steel plate.\r\n\r\nWhen starting a new freeplay game, the player starts out with 8 iron plates, along with 1 burner mining drill and 1 stone furnace.	100	3.2	Iron_plate.png	["Stone furnace", "Steel furnace", "Electric furnace"]
5	Iron chest	iron-chest	logistics	Iron chests are available to the player at the start of the game. They are, like any other means of storage, used for storing items at a fixed position. Though they cost iron plates to produce, they can store twice as many items as wooden chests, and they have twice the health. Iron chests, like other chests, can be connected to the circuit network to provide their contents as a signal.	50	0.5	Iron_chest.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3"]
6	Steel chest	steel-chest	logistics	Steel chests are the largest of three types of chests used for basic item storage. Steel processing must be researched before they can be built. Steel chests, like other chests, can be connected to the circuit network to provide their contents as a signal.\r\n\r\nA steel chest can contain 48 stacks of items. This is 50% more than an iron chest and 3 times the capacity of a wooden chest. Steel chests are used to create all logistic chests, which all share the steel chest's 48-stack capacity.	50	0.5	Steel_chest.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
7	Steel plate	steel-plate	items	The steel plate is an advanced material made by smelting iron plates again. It is used in many advanced recipes, including electrical distribution logistics, military items, and upgraded production machines. Some of these products in turn are used in the production science pack, which requires a total of 25 steel plates.\r\n\r\nBecause the recipe for steel contains a ratio of 5 iron : 1 steel, it requires less space to transport once processed. Because of this, it is easier to transport the finished steel instead of smelting the steel where it needs to be used.	100	16	Steel_plate.png	["Stone furnace", "Steel furnace", "Electric furnace"]
8	Storage tank	storage-tank	logistics	The storage tank is a building that can store up to 25,000 units of a fluid. It is a passive storage — it has no input and no output, essentially acting as volume increase of the pipe segment it is connected to.	50	3	Storage_tank.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
10	Steam	steam	items	Steam is a gas created by heating water in a boiler or heat exchanger. After being distributed via pipes, steam can be used to generate electricity via steam engines and steam turbines. Steam is also used in coal liquefaction in oil refineries. Since steam is a fluid, it can be stored in a storage tank.	50	0.5	Steam.png	["Boiler", "Heat exchanger"]
11	Crude oil	crude-oil	items	Crude oil is a liquid extracted by pumpjacks from oil fields and can be converted to petroleum gas, light oil, and heavy oil by an oil refinery. It can be transported either in pipes, barrels or fluid wagons. Crude oil is also found on Aquilo.\r\n\r\nIt can also be used as ammo in flamethrower turrets.	50	0.5	Crude_oil.png	["Pumpjack"]
12	Heavy oil	heavy-oil	items	Heavy oil is a liquid produced by refining crude oil in an oil refinery. It can be processed into light oil, solid fuel and lubricant. It is more efficient to process heavy oil into light oil before creating solid fuel from it. It can also be used as ammo in flamethrower turrets.\r\nThis can be upgraded to coal liquefaction once some initial heavy oil has been obtained.	50	3	Heavy_oil.png	["Oil refinery"]
13	Light oil	light-oil	items	Light oil is a liquid converted from crude oil (in a oil refinery) or heavy oil (in a chemical plant).\r\n\r\nLight oil can be converted to petroleum gas, or used to create solid fuel and rocket fuel. It can also be used as ammo in flamethrower turrets.	0	5	Light_oil.png	["Oil refinery", "Chemical plant"]
14	Lubricant	lubricant	items	Lubricant is a fluid converted from heavy oil in a chemical plant. Like other fluids, it may be barreled.\r\n\r\nIt is used in the production of express transport belts (blue belts) and their counterpart underground belts and splitters. It is also used to create electric engine units.	50	1	Lubricant.png	["Chemical plant"]
15	Petroleum gas	petroleum-gas	items	Petroleum gas is a fluid created in an oil refinery from crude oil or coal, or in a chemical plant from light oil. Petroleum gas is used to create plastic bars and sulfur, important ingredients for mid-to-high-level recipes.\r\n\r\nPetroleum gas can also be used to create solid fuel, but the ratio of fuel created is not as efficient as that of light oil, and petroleum gas is usually too valuable to waste.	50	5	Petroleum_gas.png	["Oil refinery"]
16	Sulfuric acid	sulfuric-acid	items	Sulfuric acid is a liquid that is used to create batteries and processing units. It must also be piped into electric mining drills to mine uranium ore. It is produced in a chemical plant from sulfur, water, and iron plates.\r\n	50	1	Sulfuric_acid.png	["Chemical plant"]
18	Coal	coal	items	Coal is a resource found on Nauvis. It can also be found inside huge rocks on Nauvis. It is used as fuel in burner devices. It is also a component in several weapons (such as grenades) and plastic bars.	50	1	Coal.png	["Burner mining drill", "Electric mining drill", "Player"]
19	Stone	stone	items	Stone is a resource found on the map on Nauvis. It is used for crafting stone furnaces, rails, landfill, and can be smelted into stone bricks in a furnace.\r\nIn addition to stone resource patches, stone can be mined from rocks on Nauvis	50	1	Stone.png	["Burner mining drill", "Electric mining drill", "Player"]
21	Uranium ore	uranium-ore	items	Uranium ore is a resource found on the map. Instead of being smelted in a furnace, uranium ore must be processed in a centrifuge to produce uranium-235 and uranium-238, which is used to craft fuel for the nuclear reactor and in various types of ammunition.\r\n\r\nUranium ore is different from the other ores, as it requires sulfuric acid to be fed into the electric mining drill to mine it, at a rate of 10 sulfuric acid per 10 ore mined. Because of this, uranium ore cannot be mined by hand or by a burner mining drill, as it lacks fluid inputs. No additional sulfuric acid is consumed when additional products are created due to a productivity bonus from productivity modules or mining productivity. For example, with a 20% productivity bonus, 12 ore will be mined for every 10 sulfuric acid consumed. The ore has a green glow, making it easily seen at night.\r\n\r\nAssuming no productivity or reactor neighbor bonuses are involved, and if Kovarex enrichment process is used to convert excess uranium-238 into uranium-235, one uranium ore has a total energy value of 368.73 MJ when made into uranium fuel cells, about 92 times the energy of coal.	50	2	Uranium_ore.png	["Electric mining drill"]
22	Raw fish	raw-fish	items	Raw fish can be harvested from water. They can be used to refill a small amount of health instantly. In order to catch raw fish, mine one of the dark spots that can be found moving around in water bodies. Each dark spot yields 5 fish when mined. Fish can be also collected via construction robots, by marking a water area that contains fish with a deconstruction planner.\r\n\r\nRaw fish is used to heal by clicking on the character or anywhere else in the world with the fish in the cursor. They heal 80 HP each and have a short cooldown for reuse, limiting the amount of incoming DPS that fish healing can absorb. Using a fish produces a munching sound.\r\nFish are created in water when the world is generated and do not despawn or respawn. While inserters can remove fish from the water, they cannot put them back. The player can manually return fish to the water in stacks of 5, which resets both the quality and freshness of the fish.	100	0.4	Raw_fish.png	["Player"]
23	Copper plate	copper-plate	items	Copper plate is a material that can be made by smelting copper ore in a furnace. The copper plate's use is small in early game, so many players underestimate how much production capacity they will need. In the later game, copper use picks up heavily with the mass production of electronic circuits, and other resources that consume copper. However, copper use will usually still be less than iron plate use, throughout the game.	100	3.2	Copper_plate.png	["Stone furnace", "Steel furnace", "Electric furnace"]
24	Solid fuel	solid-fuel	items	Solid fuel is a kind of fuel and is processed in a chemical plant. One unit of solid fuel contains 12MJ of energy, three times the energy value of coal.\r\n\r\nBesides being useful as fuel in all burner devices, solid fuel is also used to produce rocket fuel, which is a component of rocket parts built in the rocket silo.	50	1	Solid_fuel.png	["Chemical plant"]
25	Plastic bar	plastic-bar	items	Plastic bars are a requirement for the production of advanced circuits which are highly used towards the mid to late game. Plastic is also needed in large quantities to launch a rocket and win the game due to its use in crafting low density structures.	100	1	Plastic_bar.png	["Chemical plant"]
26	Battery	battery	items	The battery is an intermediate product used in several key recipes, including the flying robot frame, which is required to build logistic and construction robots, as well as the utility science pack used for later-game research.\r\nFurthermore, batteries are a crucial component of powering a factory using solar power. Batteries are also used for defense, as they are needed to make laser turrets, which uses electricity instead of ammunition in item or fluid form.	200	4	Battery.png	["Chemical plant"]
27	Explosives	explosives	items	Explosives are used in crafting of cliff explosives and explosive weapons and ammunition. Explosives cannot be used by themselves.	50	0.5	Explosives.png	["Chemical plant"]
28	Barrel	barrel	items	Barrels can be used to store and transport 50 units of various fluids. Since they are solid objects, they can be used as an alternative to pipes, once fluid handling is researched. The barrels themselves are reusable once the fluids are drained.\r\nBarrels stack in groups of 10. A single cargo wagon can hold 400 barrels, which gives a capacity of 20,000 units per cargo wagon – 30,000 fewer units than the capacity of a fluid wagon.\r\n	10	1	Barrel.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
29	Fill crude oil barrel\t	fill-crude-oil-barrel\t	items	Filled barrels cannot be crafted. They are filled using the respective fluids's Fill barrel process which consumes empty barrels.	10	0.2	Fill_crude_oil_barrel.png	["Assembling machine 2", "Assembling machine 3"]
44	Electric engine unit	electric-engine-unit	items	An Electric engine unit is the advanced counterpart of the engine unit, and is used in some higher end recipes.\r\n\r\nNote that lubricant requires a chemical plant to be created, and engine units require assembling machines, so electric engines cannot be built by hand from raw materials.	50	10	Electric_engine_unit.png	["Assembling machine 2", "Assembling machine 3"]
31	Fill light oil barrel\t	fill-light-oil-barrel	items	Filled barrels cannot be crafted. They are filled using the respective fluids's Fill barrel process which consumes empty barrels.	10	0.2	Fill_light_oil_barrel.png	["Assembling machine 2", "Assembling machine 3"]
32	Fill lubricant barrel\t	fill-lubricant-barrel\t	items	Filled barrels cannot be crafted. They are filled using the respective fluids's Fill barrel process which consumes empty barrels.	10	0.2	Fill_lubricant_barrel.png	["Assembling machine 2", "Assembling machine 3"]
33	Fill petroleum gas barrel\t	fill-petroleum-gas-barrel\t	items	Filled barrels cannot be crafted. They are filled using the respective fluids's Fill barrel process which consumes empty barrels.	10	0.2	Fill_petroleum_gas_barrel.png	["Assembling machine 2", "Assembling machine 3"]
34	Fill sulfuric acid barrel\t	fill-sulfuric-acid-barrel	items	Filled barrels cannot be crafted. They are filled using the respective fluids's Fill barrel process which consumes empty barrels.	10	0.2	Fill_sulfuric_acid_barrel.png	["Assembling machine 2", "Assembling machine 3"]
35	Fill water barrel	fill-water-barrel	items	Filled barrels cannot be crafted. They are filled using the respective fluids's Fill barrel process which consumes empty barrels.	10	0.2	Fill_water_barrel.png	["Assembling machine 2", "Assembling machine 3"]
36	Iron gear wheel	iron-gear-wheel	items	The iron gear wheel is an intermediate product crafted from two iron plates. It is very important for many basic and advanced recipes, including all levels of belts, the basic inserter and assembler, and raw resource extraction equipment such as the electric mining drill.	100	0.5	Iron_gear_wheel.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
37	Iron stick	iron-stick	items	Iron sticks are a basic intermediate product. They are used in a few early and mid-game recipes.	100	0.5	Iron_stick.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
38	Copper cable	copper-cable	items	This article is about the intermediate product. For the tool for connecting electric poles, see copper wire.\r\nCopper cables are an intermediate product made from copper plates. They are very important for manufacturing circuits, circuit network combinators, and power poles.	200	0.5	Copper_cable.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
40	Advanced circuit	advanced-circuit	items	Advanced circuits (or "red circuits") are used as components in most high-tech items, most notably in chemical science packs, but also logistics robot items, modules, and equipment. They require an oil processing setup as they are produced using plastic bars.\r\n\r\nAdvanced circuits are slower to build than most other intermediate components, require three inputs, and are in high demand. As an example of the demand, a finished productivity module 3 requires a total of 190 advanced circuits. Due to their slow build time, assembling machine 3s with speed modules may be useful in their production.	200	6	Advanced_circuit.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
41	Processing unit	processing-unit	items	The Processing Unit (or "blue circuit") is the third tier of circuit, and is used in many late game recipes, mainly for making utility science packs, modules, modular armor and its equipment, the rocket silo and parts for the rocket.	100	10	Processing_unit.png	["Assembling machine 2", "Assembling machine 3"]
43	Pipe	pipe	items	The pipe is the most basic method of distribution of fluids. It is commonly used to provide water from offshore pumps to boilers and steam to steam engines for power generation, and later on, crude oil and oil products. Unlike transport belts, players and enemies can't walk over them.\r\n\r\nComprehensive information on fluid distribution can be found on the fluid system page.\r\n\r\nAttempting to build a pipe that would potentially mix two liquids will fail, as the pipe won't be placed. Undesired fluid can be flushed from the pipe system by opening the pipe GUI and clicking the trash button next to the fluid. Fluids that are flushed from pipes are deleted permanently.	100	0.5	Pipe.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
42	Engine unit	engine-unit	items	An Engine unit is used for building various vehicles, such as trains and cars. Engine units must be built using an assembling machine, and cannot be made by hand.\r\n\r\nOptimized time/item usage: 2 pipe factories + 1 iron gear wheel factory → 20 engine unit factories.	50	10	Engine_unit.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3"]
45	Flying robot frame	flying-robot-frame	items	The Flying robot frame is a high-end component used to build logistic and construction robots.\r\n\r\nNote that while the frame itself can be built by hand, many of its components and subcomponents cannot. Batteries require a chemical plant, and electric engine units use lubricant (from another chemical plant) and engine units (which require assembling machines).	50	20	Flying_robot_frame.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
49	Uranium-235	uranium-235	items	Uranium-235 is, along with uranium-238, one of the refined products of uranium ore. It is used in the production of nuclear fuels and the atomic bomb. Uranium-235 is produced through uranium processing in a centrifuge, or through the Kovarex enrichment process.\r\n\r\nUranium-235 is much rarer than its counterpart, uranium-238. A centrifuge processing uranium ore will produce roughly 1 unit of uranium-235 for every 142 units of uranium-238, which requires about 1430 units of uranium ore, making it one of most expensive products in the game. Once 40 units have been amassed, it can be generated much more quickly through the Kovarex process.	100	1704	Uranium-235.png	["Centrifuge"]
57	Inserter	inserter	logistics	For the article encompassing all inserter types, see Inserters.\r\n\r\nThe inserter can be used to transfer items between entities such as transport belts and stone furnaces. It is the most basic electric inserter.\r\n\r\nUnlike the fast inserter, the inserter is not fast enough to pick up items moving on the far side of a curving express transport belts.\r\nThe inserter is notable in that it is used in the creation of logistic science pack, so players must create an automated inserter assembly line. The basic inserter is also used in the creation of both the fast inserter and the long inserter, and serves as the base item for all electric inserters.\r\n	50	0.5	Inserter.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
46	Low density structure	low-density-structure	items	The low density structure is used in the production of modular armor & equipment, utility science packs, and orbital rockets.	50	15	Low_density_structure.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
47	Rocket fuel	rocket-fuel	items	Used in the production of orbital rockets. It is the second-most long-lasting of all the fuel types, beat only by Nuclear fuel. Rocket fuel can also be used in burner devices to provide 100MJ of energy, however this is slightly less efficient than using 10 solid fuels unless extra products are created using productivity modules.\r\n\r\nVanilla: 10 rocket fuel are required for each rocket part, so 1000 rocket fuel are needed for each rocket launch. Additionally 50 rocket fuel are required for each satellite.	20	15	Rocket_fuel.png	["Assembling machine 2", "Assembling machine 3"]
48	Rocket part	rocket-part	items	Rocket parts are items created by a rocket silo. Once enough rocket parts have been created, a rocket is built which can launch materials into space. Rocket parts are stored within the silo itself, are not accessible to machines or the player and will be lost if the rocket silo is deconstructed.\r\n\r\nIn the base game, a rocket requires 100 rocket parts, while in Space Age only 50 are required and the cost of each part is significantly reduced. Space Age also adds the productivity technology rocket part productivity (research), which effectively makes rocket parts less expensive.	5	3	Rocket_part.png	["Rocket silo"]
50	Uranium-238	uranium-238	items	Uranium-238 is, along with uranium-235, one of the refined products of uranium ore when the ore is processed through a centrifuge, or the Kovarex enrichment process. Uranium-238 is vastly more common than uranium-235, with a 99.3% chance of appearing after being processed. Both isotopes of uranium are the main ingredients for most components of nuclear power generation. Uranium-238 can also be extracted from depleted uranium fuel cells using nuclear fuel reprocessing.	100	12	Uranium-238.png	["Centrifuge"]
51	Uranium fuel cell	uranium-fuel-cell	items	The uranium fuel cell is a fuel used exclusively by the nuclear reactor to produce heat. It cannot be used in other burner devices or vehicles.\r\n\r\nUnlike boilers, a nuclear reactor will continue to burn fuel regardless of heat consumption. A uranium fuel cells burns for 200 seconds.\r\n\r\nRather than completely consuming fuel, burning a uranium fuel cell results in a depleted uranium fuel cell, which can be reprocessed in a centrifuge to recover some uranium-238.	50	10	Uranium_fuel_cell.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
52	Depleted uranium fuel cell	depleted-uranium-fuel-cell	items	A depleted uranium fuel cell is produced in nuclear reactors by burning a uranium fuel cell. It can be reprocessed into uranium-238.	50	200	Depleted_uranium_fuel_cell.png	["Nuclear reactor"]
53	Nuclear fuel	nuclear-fuel	items	Nuclear fuel is a type of fuel. It has the highest energy density and vehicle bonuses of all the fuel types, providing an acceleration modifier of 250% (compared to rocket fuel's 180%). The vehicle top speed modifier (115%) is the same as for rocket fuel.\r\n\r\nNuclear fuel is made from rocket fuel and uranium-235, one of each to produce one unit of nuclear fuel.\r\n\r\nCompared to rocket fuel, nuclear fuel not only gives a higher acceleration bonus, but also has more than twelve times the energy output per item. Despite its smaller Rocket capacity (10 vs 100), this gives nuclear fuel an advantage in Space Age when moving energy from a planet to a platform. However, due to the much smaller stack size (1 vs 20), it is less space-efficient.	1	90	Nuclear_fuel.png	["Centrifuge"]
54	Nuclear fuel reprocessing	nuclear-fuel-reprocessing	items	Nuclear fuel reprocessing can be used to recycle depleted uranium fuel cells into uranium-238.	0	60	Nuclear_fuel_reprocessing.png	["Centrifuge"]
55	Automation science pack	automation-science-pack	items	Automation science pack (also referred to as "red science") is the first tier of science pack. It is used in labs to research technologies.	200	5	Automation_science_pack.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
58	Transport belt	transport-belt	logistics	The transport belt is the easiest and cheapest method of automatic item transportation. It is the first tier of transport belts.\r\n\r\nNo prior research is required and it is available from the beginning of the game.	100	0.5	Transport_belt.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
56	Logistic science pack	logistic-science-pack	items	Logistic science pack (also referred to as "green science") is the second tier of science pack. It is used in labs to research technologies.	200	6	Logistic_science_pack.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
59	Military science pack	military-science-pack	items	The Military science pack is one of the four early game science packs, the other three being the automation science pack, the logistic science pack, and the chemical science pack. It is used for research that allows the player to advance their military strength through the entire game, unlocking more bullet choices, gun choices, turrets, etc. It is the only type of science pack that is optional, in that it is not required to launch a rocket.	200	10	Military_science_pack.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
61	Firearm magazine	firearm-magazine	combat	The most basic ammunition for starting weapons. Cheap, but has limited damage.	100	1	Firearm_magazine.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
62	Piercing rounds magazine	piercing-rounds-magazine	combat	A more advanced ammunition type for gun weapons.\r\n\r\nMore resource intensive than Firearm magazines, but has 60% higher damage.	100	6	Piercing_rounds_magazine.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
64	Stone brick	stone-brick	logistics	Stone bricks are produced from stone in any furnace, and are used in multiple recipes as well as placing them to create stone paths.\r\n\r\nRecipes in which they are used include the two advanced types of furnace (meaning they are used in research), as well as more advanced stone products, notably concrete. It is more material efficient to use concrete for paths, as double the amount of tiles are produced from the same amount of stone.\r\n\r\nStone path increases walking speed by 30% and reduces vehicle rolling resistance, allowing for improved acceleration and top speed. However, any type of path practically prevents pollution absorption by terrain, so extensive use of paths may cause the factory's pollution to spread farther. Stone paths have no effect on the movement speed of enemies.\r\n\r\nStone brick crafting can use productivity modules.	100	3.2	Stone_brick.png	["Stone furnace", "Steel furnace", "Electric furnace"]
65	Chemical science pack	chemical-science-pack	items	Chemical science pack (also referred to as "blue science") is the third tier of science pack. It is used in labs to research advanced technologies.	200	24	Chemical_science_pack.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
66	Electric furnace	electric-furnace	production	The electric furnace is the third and last tier of furnace. As its name implies, it uses electricity rather than fuel to operate, removing the need for a fuel belt.\r\n\r\nThe electric furnace smelts items at the same speed as a steel furnace, and also has two slots for modules. However, it is slightly larger than the other two tiers of furnaces; it occupies a 3×3 area instead of a 2×2 area.	50	5	Electric_furnace.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
67	Productivity module	productivity-module	production	Productivity modules applies a productivity bonus to items produced in a machine, allowing the machine to produce more items for the same inputs. It adds 4% productivity to the affected machine.\r\n\r\nProductivity modules can generally only be used to make intermediate products. These are items that are used in other recipes and cannot directly be placed.	50	15	Productivity_module.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
68	Rail	rail	logistics	A Rail is used for building a railway track for trains. Unlike transport belts, rail tracks can also be curved and placed diagonally. Train stops, rail signals and rail chain signals can be placed on rails to better guide automated trains. Gates can also be placed on rails, making them rail gates.\r\nThe minimum rail turning radius is 13, meaning the smallest possible 180° turn has 26 tiles between the centers of opposite rails. However, due to rails being two tiles wide, the actual footprint is 28 tiles wide.\r\n\r\nThe rail planner can be used to automatically place rails. See the page for more info	100	0.5	Straight_rail.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
69	Production science pack	production-science-pack	items	The Production science pack is one of the three late-game science packs in the base game, the other two being the utility science pack, and the space science pack.	200	21	Production_science_pack.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
70	Utility science pack	utility-science-pack	items	The Utility science pack is one of three late-game science packs, the other two being the production science pack, and the space science pack.	200	21	Utility_science_pack.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
71	Fast transport belt	fast-transport-belt	logistics	Fast transport belts are a faster variant of the transport belt, operating at double speed. They are the second tier of transport belts.	100	0.5	Fast_transport_belt.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
77	Fast splitter	fast-splitter	logistics	Fast splitters are splitters which are twice as fast as normal splitters, but only 67% as fast as express splitters. The items are placed in 1:1 relation on the outgoing belts. It is possible to set a filter and input and output priorities as described on belt transport system.	50	2	Fast_splitter.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
80	Long-handed inserter	long-handed-inserter	logistics	The Long-handed inserter is an electric inserter that picks up and places items two tiles from its location instead of the usual one. They are commonly used for placing items on a belt that is three tiles away from either an assembling machine or a furnace.\r\n\r\nLong-handed inserters may have trouble grabbing moving items from red/blue turning belts if the item is on the far side. They can also grab items past north facing cliffs that go straight across, though cliffs of any other kind are too thick for the inserter to reach across.\r\n\r\nFor more information on mechanics and uses see Inserters.	50	0.5	Long-handed_inserter.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
73	Underground belt	underground-belt	logistics	The underground belt is the first tier of underground belts. This type of belt is generally used to allow a transport belt to cross another transport belt by going underneath it. The underground belt has a maximum underground distance of 4 squares.\r\n\r\nThe speed of the underground belt is the same as the speed of the basic transport belt.	50	1	Underground_belt.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
74	Fast underground belt	fast-underground-belt	logistics	The fast underground belt is the second tier of underground belts. It has a maximum underground distance of 6 tiles — 2 more than the basic underground belt. The speed of the fast underground belt is the same speed as the fast transport belt, which is twice as fast as a basic transport belt or underground belt.	50	2	Fast_underground_belt.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
75	Express underground belt	express-underground-belt	logistics	The Express underground belt is the third tier of underground belts. It has a maximum underground length of 8 tiles ‒ 2 more than a fast underground belt and 4 more than a basic underground belt. The speed of the express underground belt is the same speed as the express transport belt, which is three times as fast as a basic transport belt or underground belt.	50	2	Express_underground_belt.png	["Assembling machine 2", "Assembling machine 3"]
76	Splitter	splitter	logistics	The splitter is used to divide a single belt, combine two belts into one, or equally balance two belts together. The items are placed in 1:1 relation on the outgoing belts. It is possible to set a filter and input and output priorities as described on belt transport system.	50	1	Splitter.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
78	Express splitter	express-splitter	logistics	Express splitters are splitters which are three times as fast as normal splitters and 50% faster than fast splitters. The items are placed in 1:1 relation on the outgoing belts. It is possible to set a filter and input and output priorities as described on belt transport system.	50	2	Express_splitter.png	["Assembling machine 2", "Assembling machine 3"]
81	Fast inserter	fast-inserter	logistics	The fast inserter is an electric inserter that is more than twice as fast as the regular inserter.\r\n\r\nFor more information on mechanics and uses see inserters.	50	0.5	Fast_inserter.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
82	Bulk inserter	bulk-inserter	logistics	The bulk inserter is an electric inserter that can move multiple items at the same time. Moving at the speed of the fast inserter, it transfers multiple items per cycle to give it a material flow advantage at the cost of additional power consumption.\r\n\r\nWhen transferring between chests or cargo wagons it picks up and drops off the entire stack of items instantly. When picking up from or dropping off items onto a transport belt a bulk inserter needs to grab or drop each item individually, increasing the time between arm swings and lowering its potential throughput. In these cases, however, the bulk inserter still has higher throughput than a fast inserter because it swings back and forth less often. The throughput from chest to chest for a fully upgraded bulk inserter is 27.69 items per second, but only 13.85 items/s from chest to express belt.\r\n\r\nA bulk inserter cannot carry more items than the item's stack size.	50	0.5	Bulk_inserter.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
83	Small electric pole	small-electric-pole	logistics	The small electric pole is the basic electric pole. It has a short wire reach and small supply area, but it is also available from the beginning of the game. Typically, it is replaced in factories by medium electric poles later in the game. It can also carry signals for the circuit network.	50	0.5	Small_electric_pole.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
84	Medium electric pole	medium-electric-pole	logistics	The medium electric pole is an improved electric pole that is superior to the small electric pole in all regards, requiring slightly more expensive resources to produce. Although it lacks benefits of more advanced, specialized variants, it is a consummate all-rounder with decent reach, supply area and size. It can also carry signals for the circuit network.	50	0.5	Medium_electric_pole.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
92	Cargo wagon	cargo-wagon	logistics	The Cargo wagon is used in conjunction with locomotives to form trains for the railway.\r\n\r\nA wagon is used to transport items and can be filled and emptied like a chest, but with many more inserters at the same time. Up to 12 inserters per wagon are possible (from both sides). The inserter item stack size is important to fill the wagon fast!\r\n\r\nIn manual-mode cargo wagons can only be filled or emptied when they are not moving. In automated-mode it is the same, but additionally they can only filled/empty, when stopped on a train-stop (not at a signal). A spot where inserters are positioned to transfer cargo for wagons is called a train station.\r\n\r\nWagons have a stack limitation option the same way chests do, which can be used to limit the number of transported items. Each stack in the cargo wagon can be filtered. This works in the same way as the filtering slots in other vehicles; the default key to define or remove the filter is the Middle mouse button. Players can enter a cargo wagon and control any connected locomotives.	5	1	Cargo_wagon.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
86	Pipe to ground	pipe-to-ground	logistics	The pipe to ground (or "underground pipe") is a distribution method for liquids and gases. Since a basic pipe is impassable, these are necessary to keep the factory open, as well as to cross belt lines or environmental features.\r\n\r\nComprehensive information on fluid distribution can be found on the fluid system page.	50	0.5	Pipe_to_ground.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
87	Pump	pump	logistics	This article is about the pump. For the water extraction device, see offshore pump. For the oil extraction device, see pumpjack.	50	2	Pump.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
88	Train stop	train-stop	logistics	Train stops are used to automate item transportation by trains by providing nameable locations for trains to travel to. Like locomotives, the color of the stops can be customized. Furthermore, the stop can be named, with rich text making it possible to further customize the name, such as by adding item icons.	10	0.5	Train_stop.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
89	Rail signal	rail-signal	logistics	The rail signal divides rails into blocks and allows locomotives to react to other locomotives allowing multiple trains use the same rails without colliding. Blocks span all connected rails regardless if a train can actually travel between them. Rail signals can also be used in with conjunction rail chain signals, which also separate rails into blocks. In addition to the explanation on this page, there is also the rail signal tutorial.	50	0.5	Rail_signal.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
90	Rail chain signal	rail-chain-signal	logistics	Rail chain signals are used for automated transportation on a railway network. With rail chain signals, it is possible to use multiple trains on a single track, or multiple rails that intertwine. Rail chain signals can be used to ensure that trains only enter a crossing if they can also leave it, which ensures that they do not block other traffic by waiting on the crossing. In addition to the explanation on this page, there is also the rail signal tutorial.	50	0.5	Rail_chain_signal.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
93	Fluid wagon	fluid-wagon	logistics	The fluid wagon, also known as the rail tanker, is capable of transporting fluids by rail. Fluids can be pumped in and out of the wagon using a pump, each fluid wagon can have a maximum of 3 pumps attached at one time, 1 per tank section. Similar to cargo wagons, a locomotive is required to move the liquid wagon.\r\n\r\nThe fluid wagon can carry 50,000 units of fluid. It weighs the same of the regular cargo wagon but holds more fluid; a cargo wagon filled with barrels can carry 20,000 units of fluid.	5	1.5	Fluid_wagon.png	[]
94	Artillery wagon	artillery-wagon	logistics	The artillery wagon is an end-game wagon mounting a rail cannon that can be added to a train. It fires artillery shells, relatively slow-moving projectiles that explore chunks of terrain they travel across. The wagon gun has both automatic and manual (even longer-ranged) firing modes. Projectiles have sufficient damage to destroy spawners and any type of worm with a single hit, and have a modest area of effect. Infinitely-stacking research upgrades are available for range and firing speed, but not damage.\r\n\r\nThe artillery turret is essentially the same weapon, but deployed as a static structure like other turrets.	5	4	Artillery_wagon.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
96	Tank	tank	logistics	The tank is a heavy armored fighting vehicle. It is a mid-game vehicle with three weapons; an integrated submachine gun, a short range flamethrower and a powerful cannon that uses cannon shells. It, along with the car and spidertron, are the three non-rail vehicles in Factorio. In multiplayer, it is possible for a player to enter a tank alongside another player. The passenger can take control of the weapons of the tank using a switch in the GUI of the tank, but cannot steer the tank.\r\n\r\nSince engine units can only be built in assembling machines, tanks (like cars) cannot be built from scratch by hand from their raw materials. If the tank is destroyed, its inventory is destroyed with it, though the player gets ejected and not killed. Tanks will change color based on the color of the player who drove it last.\r\n\r\nTanks can be driven remotely. Coupled with the tank's equipment grid, the player can remotely manipulate distant outposts without being there as well as to remotely expand the base by attacking enemy nests. However, unlike the spidertron, the tank lacks any map-revealing capabilities, and so is effectively confined to areas where the player has sufficient radar coverage. The tank and its weapons continue to operate normally if driven outside of visual range, but if the player "exits" the vehicle while in the fog of war then the tank will be stranded until visual contact can be re-established.	1	5	Tank.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
97	Logistic robot	logistic-robot	logistics	Logistic robots are autonomous floating devices capable of transporting resources in a logistic network. They are one of two types of floating robotic devices, the other being construction robots.\r\n\r\nThe basic movement speed of logistic robots is 0.05 tiles/tick (3 tiles per second) when they have enough power. When out of power, robots move at 20% of their current normal travel speed. This movement speed can be increased infinitely by the worker robot speed (research).\r\n\r\nLogistic robots have no means of defending themselves and do not run when they encounter enemies. Despite being a floating entity, ground units using melee are still capable of destroying them.\r\n\r\nBy default, each robot can only carry one item. This limit can be increased up to four items by the worker robot cargo size (research). Robots consume power per tile traveled, additionally to consuming power per second spent in the air. When they run out of power, they have to recharge at a roboport, or a personal roboport, depending on where the robots were originally placed. Alternatively, they can be mined out of the air by the player which restores their internal power buffer, allowing the player to redeploy them immediately.	50	0.5	Logistic_robot.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
98	Construction robot	construction-robot	logistics	Construction robots are autonomous floating devices capable of repairing or building the player's structures. They are one of two type of floating robotic devices, the other being the logistic robots. They run on electricity from roboports, or a personal roboport.	50	0.5	Construction_robot.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
100	Passive provider chest	passive-provider-chest	logistics	The passive provider chest is a storage item that is part of the logistic network. Logistic robots will pick up items from this box to move them to the player or requester chests, but only in this direction. This makes them useful for storing items assembled in any particular area - useful as a buffer between belts or at the end of a belt. If you want the contained items to later be consolidated in storage chests, then use the active provider chest instead.\r\n\r\nConstruction robots will pick up items for construction, replacement of destroyed entities and repair packs from passive provider chests.\r\n\r\nPassive provider chests have the lowest priority as pick-up points for logistic robots. Logistic robots will not empty passive provider chests if the requested items are available in active provider chests and/or storage chests.	50	0.5	Passive_provider_chest.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
168	Distractor capsule	distractor-capsule	combat	A capsule which, when used by right-clicking, will spawn three Distractor robots at the players cursor. Distractors have infinite laser energy and will hold their general position, attacking any enemies that come within range, until they are destroyed or their lifespans elapse. The shooting speed of the distractors is increased by the laser shooting speed (research).	100	15	Distractor_capsule.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
103	Requester chest	requester-chest	logistics	The requester chest is a large advanced storage item that is part of the logistic network. Requester chests can be configured to request of a specified number of up to 1000 types of items from the network. Logistic robots will then bring the specified items from provider chests, storage chests, and buffer chests, if the "Request from buffer chests" checkbox is checked, until the request is met.\r\n\r\nWhen fulfilling requests from requester chests, logistic robots will first attempt to pick up the specified items from active provider chests, then from buffer chests if the "Request from buffer chests" checkbox is checked, then from storage chests, and lastly from passive provider chests.\r\n\r\nBy using SHIFT + Right mouse button and SHIFT + Left mouse button to copy-paste a recipe from an assembling machine to a requester chest, the requester chest is automatically configured to request enough ingredients for 30 seconds of continuous crafting.\r\n\r\nRequester chests can be disabled via a condition on the circuit network. A disabled chest will not request items even if active requests are set on it.\r\n\r\nRequester chests can be configured to read their requests from the circuit network in addition to requests set on them directly. They may also use logistic groups in the logistic network to share sets of requests with other requesters.	50	0.5	Requester_chest.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
105	Lamp	lamp	logistics	The lamp is a basic electric device providing light to a medium area (10 tile radius) at night. It can be used to increase visibility in a factory, so nightvision is not needed. Lamps can be toggled to always be on, regardless of time of day.	50	0.5	Lamp.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
106	Arithmetic combinator	arithmetic-combinator	logistics	The arithmetic combinator is part of the circuit network and one of four types of combinators available in the game (along with the constant combinator, decider combinator, and selector combinator). Each arithmetic combinator can perform any one of the following mathematical operations on signals, and will show the corresponding symbol on its top:\r\n\r\naddition (+)\r\nsubtraction (−)\r\nmultiplication (*)\r\ndivision (/)\r\nmodulo (%)\r\nexponentiation (^)\r\nbit shift left (<<)\r\nbit shift right (>>)\r\nbitwise AND (&)\r\nbitwise OR (|)\r\nbitwise XOR (^)	50	0.5	Arithmetic_combinator.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
107	Decider combinator	decider-combinator	logistics	The decider combinator is part of the circuit network and one of four types of combinators available in the game (with the other three being the constant combinator, arithmetic combinator, and selector combinator). It is used to make comparisons of signals on the network.	50	0.5	Decider_combinator.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
109	Constant combinator	constant-combinator	logistics	The constant combinator is part of the circuit network and one of four types of combinators available in the game (the other three being the arithmetic combinator, decider combinator, and selector combinator). It constantly outputs the selected signal(s) to all connected wire networks without the need for a specific input, and can be turned on/off in the GUI manually. Most common uses include testing of composed circuitry or changing some user-defined settings by broadcasting a kind of a switching signal.\r\n\r\nIf the output of a combinator is desired to be switched on/off remotely or automatically, it is recommended to channel its output through a decider combinator. Unlike the other two combinators, the constant combinator does not require electricity to function.\r\nConstant combinators can use named logistics groups to group constants, which can be shared with other logistic requesters. Logistic requests have two values for each signal: the minimum and maximum for the entity. The constant combinator will only output the minimum value. The UI for setting constants also cannot change the maximum value, so new entries in a group will set the maximum value to infinity. Modifying the constant for entries that have a maximum value set will not alter that maximum value.	50	0.5	Constant_combinator.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
110	Power switch	power-switch	logistics	The power switch is a machine used to toggle connections between copper wires. The machine can be controlled by circuit and logistics networks. The machine does not require energy itself and does not limit the throughput of the electrical network.	10	2	Power_switch.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
111	Programmable speaker	programmable-speaker	logistics	The programmable speaker is a circuit network entity that is capable of producing alerts in the form of sound, and elements on nearby players' guis. It can be connected to the circuit network to produce an alert when a signal drops below a certain value, for example.	50	0.5	Programmable_speaker.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
112	Display panel	display-panel	logistics	The display panel is a small monitor that can display icons and text above the entity. Almost every single icon in the game can be shown on a display panel. Descriptions can also be added to these entities. If connected to the circuit network, the display panel can be set up to showcase different icons and messages depending on what conditional signals are being passed to it.\r\n\r\nIf a description is included in a display panel, hovering the mouse over it will display all lines of text. There is an option that allows for the first line of a description to always be displayed above the entity even when not selected. If this option is unselected, no text will appear above the entity unless the player hovers their mouse over it. There is a second option that allows the chosen icon and first line of a description to be shown on the minimap and remote view.\r\n\r\nIt is worth noting that, unlike lamps or speakers, display panels do not use any power, and do not require electric network coverage at all.	10	0.5	Display_panel.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
113	Concrete	concrete	logistics	Concrete is an ingredient utilized for rocket silos, refined concrete, artillery turrets and facilities relating to nuclear material (reactors and centrifuges). Concrete serves as path with more advanced bonuses compared with stone bricks. Concrete increases walking speed by 40% and decreases vehicle rolling resistance, allowing for extra acceleration and top speed, although each vehicle is affected differently; the tank is only affected by a 20% bonus, for example. Concrete has no effect on the movement speed of enemies. When placed, it reduces the pollution absorption of ground to zero.	100	10	Concrete.png	["Assembling machine 2", "Assembling machine 3"]
114	Hazard concrete	hazard-concrete	logistics	Hazard concrete is identical to concrete except for its striped texture. Rotating the tile changes the direction of the stripes.	100	0.2	Hazard_concrete.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
115	Refined concrete	refined-concrete	logistics	Refined concrete is used as pathing, similar to concrete, but it has a larger brick texture and 10% higher walking speed. Refined concrete increases walking speed by 50% and decreases vehicle rolling resistance, allowing for extra acceleration and top speed, although each vehicle is affected differently; the tank is only affected by a 20% bonus, for example. Refined concrete has no effect on the movement speed of enemies.	100	15	Refined_concrete.png	["Assembling machine 2", "Assembling machine 3"]
116	Refined hazard concrete	refined-hazard-concrete	logistics	Refined hazard concrete is identical to refined concrete except for its striped texture. Rotating the tile changes the direction of the stripes.	100	0.2	Refined_hazard_concrete.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
123	Solar panel	solar-panel	production	Solar panels are an unlimited source of free energy that produce no pollution. On a planet, the power output varies based on the time of day. During the day (half of a day/night cycle), all panels provide a constant, maximum power level. Generated power will increase/decrease linearly during dawn and dusk, and no power is produced at night.\r\n\r\nThe baseline power generated by a panel is 60 kW; this represents 100% power production.\r\n\r\nOn Nauvis, one solar panel produces an average of 42 kW over a day/night cycle.	50	10	Solar_panel.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
119	Repair pack	repair-pack	production	Repair packs are used to repair items. They can be used by the player character with the Left mouse button or by construction robots. Each repair pack repairs 600 health to a building, 2 per tool durability. Repair packs can only be used on buildings already placed, and can't repair something in the player's inventory.	100	0.5	Repair_pack.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
121	Stone furnace	stone-furnace	production	The stone furnace is the most basic smelting machinery, providing a cheap and reliable source of basic products like iron plates and copper plates.	50	0.5	Stone_furnace.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
124	Accumulator	accumulator	production	The Accumulator stores a limited amount of energy when available production exceeds demand, and releases it in the opposite case. The accumulator can store up to 5 MJ of energy. Its maximum charge/discharge rate is 300 kW. If connected to a circuit network, an accumulator will output its level of charge, rounded to the nearest integer from 0 to 100, to a specified signal.	50	10	Accumulator.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
143	Efficiency module 2	efficiency-module-2	production	Efficiency module 2 reduces the electricity cost to run the machine by 40% of its base energy usage.\r\nNote that minimal energy usage is 20% of base energy usage, but using more than 80% worth of efficiency modules makes sense if other modules are used, as they increase power usage and that effect is additive with the decrease from efficiency modules.\r\n\r\nEfficiency modules also reduce pollution, because it is directly proportional to the machine's power consumption, see pollution.	50	30	Efficiency_module_2.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
144	Efficiency module 3	efficiency-module-3	production	Efficiency module 3 reduces the electricity cost to run the machine by 50% of its base energy usage.\r\nNote that minimal energy usage is 20% of base energy usage, but using more than 80% worth of efficiency modules makes sense if other modules are used, as they increase power usage and that effect is additive with the decrease from efficiency modules.\r\n\r\nEfficiency modules also reduce pollution, because it is directly proportional to the machine's power consumption, see pollution.	50	60	Efficiency_module_3.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
145	Productivity module 2	productivity-module-2	production	Productivity module 2 applies a productivity bonus to items produced in a machine, allowing the machine to produce more items for the same inputs. It adds 6% productivity to the affected machine.\r\n\r\nProductivity modules can generally only be used to make intermediate products. These are items that are used in other recipes and cannot directly be placed. 	50	30	Productivity_module_2.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
126	Heat pipe	heat-pipe	production	The heat pipe can transport heat over longer distances and connect devices which produce and use heat. Currently, this is limited to heat exchangers, nuclear reactors.\r\nHeat pipes have a heat capacity of 1 MJ/°C. Thus, they can theoretically buffer 500 MJ of heat energy across their working range of 500°C to 1000°C, making them a space-efficient energy store. However, because temperature needs a drop of greater than 1 degree before it will "flow," you can't raise them all the way to 1000°C or drain them all the way to 500°C, so the practical energy capacity will depend on the layout.\r\n\r\nAs heat pipes rise in temperature, they will give off a very low-distance glow.	50	1	Heat_pipe.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
127	Heat exchanger	heat-exchanger	production	The heat exchanger exchanges heat between a heat connection and water to produce steam.\r\nHeat exchangers produce ~103 steam with a temperature of 500°C every second.\r\n\r\nHeat exchangers will not produce steam until they reach 500°C. The steam produced is exactly 500°C hot, even if the exchanger is hotter. Heat exchangers have a heat capacity of 1 MJ/°C. Thus, they can buffer 500 MJ of heat energy across their working range of 500°C to 1000°C, and require 485 MJ of energy to warm up from 15°C to 500°C when initially placed.	50	3	Heat_exchanger.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
129	Burner mining drill	burner-mining-drill	production	The burner mining drill is the first type of drill accessible to the player. It burns fuel to mine the ore underneath the 2×2 area it is placed on.\r\n\r\nIt mines about 7 items per single unit of coal used to fuel it, producing 0.25 items/s for copper ore, coal, iron ore or stone. Burner miners create a lot of pollution per item.\r\n\r\nBurner drills are usually used until the player has built an electrical network, at which point the larger and faster electric mining drill becomes more useful, though they can still provide some use as extra drills that take up less space.	50	2	Burner_mining_drill.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
130	Steel furnace	steel-furnace	production	The steel furnace is the second-tier of furnaces. Compared to the stone furnace, it smelts at double the speed and therefore is a more efficient use of the given fuel. Steel furnace is comparable to electric furnace in terms of smelt speed, however the latter can make use of modules (as well as electricity) to further enhance the furnace's capabilities.	50	3	Steel_furnace.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
131	Assembling machine 1	assembling-machine-1	production	Assembling machine 1 is the most basic assembling machine. As Automation is the first technology available, this is the first available crafting machine. It is capable of crafting most recipes, including its own recipe. However, unlike higher tier assembling machines, it cannot use fluids for crafting.	50	0.5	Assembling_machine_1.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
132	Assembling machine 2	assembling-machine-2	production	The assembling machine 2 is an upgraded version of the assembling machine. It has a faster crafting speed and higher power consumption than the assembling machine 1. Unlike the first assembling machine, the assembling machine 2 supports crafting with fluids and using modules to increase the speed or efficiency of production.\r\n\r\nIt can make recipes that include liquids as one of their ingredients (e.g. processing unit) or products (e.g. empty crude oil barrel). The input pipe/output pipe connects to the centre of a side. The pipe will only connect when a recipe that requires or produces a liquid is selected. The pipe starts at the top by default, but its location can be rotated by hovering over the machine and pressing R.	50	0.5	Assembling_machine_2.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
133	Assembling machine 3	assembling-machine-3	production	The assembling machine 3 is the third and final tier of assembly machines, having the fastest crafting speed of all three. Like the assembling machine 2, it can use liquids in crafting.	50	0.5	Assembling_machine_3.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
135	Oil refinery	oil-refinery	production	The Oil Refinery processes crude oil or coal into 3 different fluids: heavy oil, light oil and petroleum gas.\r\n\r\nOil products have many uses. Although they can be turned into solid fuel to fuel boilers and furnaces, they are usually used to create plastic bars, which are used in advanced circuits, and sulfur, which is used in more advanced items. They are also used as ammunition for flamethrower turrets.	10	8	Oil_refinery.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
136	Chemical plant	chemical-plant	production	The chemical plant is a building for processing fluids and solids, usually through chemical processes. Many recipes that either require or provide a fluid other than crude oil are produced here. The chemical plant has 2 inputs and 2 outputs in fixed positions (their positions can be flipped). Solid items can be both inserted and removed by inserters from any point (no need to target fluid input/output connections).\r\n\r\nWhen chemical plants are in the process of crafting an item, they will billow out smoke that matches the color of their input ingredients.	10	5	Chemical_plant.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
137	Centrifuge	centrifuge	production	The Centrifuge processes uranium ore and splits it into uranium-235 and uranium-238. Centrifuges can also be used to reprocess used nuclear fuel or enrich extra uranium-235 to get more out of the available uranium.	50	4	Centrifuge.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
139	Beacon	beacon	production	A beacon is a device that transmits module effects to nearby non-burner machines, in a 9×9 square, while also boosting the effects of said modules. A beacon allows transmitting the effect of a module to multiple machines, and multiple beacons can affect the same machine, albeit with diminishing returns. Additionally, beacons can provide boosts beyond the normal limits of internal module slots.\r\n\r\nThe beacon emanates an electrical charge at a steady interval, the color changes depending on which modules are placed into the beacon, or if it contains none at all.	20	15	Beacon.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
140	Speed module 2	speed-module-2	production	Speed module 2 increases a machine's speed by 30%, its energy consumption by 60%. This means that, at the cost of energy, the machine produces more items per minute.\r\n\r\nThe machine will consume more energy per second, but will also work more quickly. Because energy costs are based on time rather than number of operations, some of the increased energy cost is offset by the reduced time per operation.\r\n\r\nMachine speed and energy consumption are increased by 10% compared to tier 1 modules.\r\n\r\nThe quality bonus of any machine can never fall below 0, meaning speed modules cannot reduce the quality of a machine's output. The quality penalty only counteracts the effect of quality modules.\r\n\r\nSpeed modules also increase pollution, because it is directly proportional to the machine's power consumption, see pollution.	50	30	Speed_module_2.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
141	Speed module 3	speed-module-3	production	Speed module 3 increases a machine's speed by 50%, its energy consumption by 70%. This means that, at the cost of energy, the machine produces more items per minute.\r\n\r\nThe machine will consume more energy per second, but will also work more quickly. Because energy costs are based on time rather than number of operations, some of the increased energy cost is offset by the reduced time per operation.\r\n\r\nThe machine speed and energy consumption effects of the module are increased by 30% compared to tier 1 modules and by 20% percent compared with tier 2 modules.\r\n\r\nThe quality bonus of any machine can never fall below 0, meaning speed modules cannot reduce the quality of a machine's output. The quality penalty only counteracts the effect of quality modules.\r\n\r\nSpeed modules also increase pollution, because it is directly proportional to the machine's power consumption, see pollution.	50	60	Speed_module_3.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
167	Defender capsule	defender-capsule	combat	A basic capsule which, when used, will spawn a single defender robot. The defender has infinite ammunition and will follow the player, attacking any enemies that come within range, until it is destroyed or its lifespan elapses.	100	8	Defender_capsule.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
142	Efficiency module	efficiency-module	production	Efficiency module reduces the electricity cost to run the machine by 30% of its base energy usage. Note that minimal energy usage is 20% of base energy usage, so 3 efficiency modules would satisfy that. However, using more than 80% worth of efficiency modules makes sense if other modules are used, as they increase power usage and that effect is additive with the decrease from efficiency modules.\r\n\r\nEfficiency modules also reduce pollution, because it is directly proportional to the machine's power consumption, see pollution.	50	15	Efficiency_module.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
149	Combat shotgun	combat-shotgun	combat	An advanced shotgun with good range, damage and higher rate of fire than that of the standard shotgun. The damage bonus of the combat shotgun stacks multiplicatively with physical projectile damage (research).	5	10	Combat_shotgun.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
150	Rocket launcher	rocket-launcher	combat	The rocket launcher is a strong weapon against enemy bases. It has long range and high damage, but as the ammo is very expensive it is recommended to avoid using it against enemy creatures. The weapon is also used to create the versatile, lategame spidertron.	5	10	Rocket_launcher.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
151	Flamethrower	flamethrower	combat	The flamethrower is an advanced weapon best used against hordes of enemies or trees. It deals initial splash damage in a large area and damage over time until the fire goes out. The damage is usually enough to destroy a biter nest with just one attack. It requires flamethrower ammo to function.\r\n\r\nSpraying fire in one spot long enough will increase the burning time of that spot, as well as create a gradually growing area of flames, depending on how long the fire was sprayed there.	5	10	Flamethrower.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
152	Uranium rounds magazine	uranium-rounds-magazine	combat	The most advanced ammunition type for gun weapons. It's more resource intensive than piercing rounds, but has three times the damage output.	100	10	Uranium_rounds_magazine.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
153	Shotgun shells	shotgun-shell	combat	Basic shells for all shotguns, and can be used to craft the more powerful piercing shotgun shells.	100	3	Shotgun_shells.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
154	Piercing shotgun shells	piercing-shotgun-shell	combat	Advanced shells for all shotguns. They have four extra pellets per shot compared to normal shotgun shells.	100	8	Piercing_shotgun_shells.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
155	Cannon shell	cannon-shell	combat	The cannon shells are the basic ammunition for the tank along with explosive cannon shells. Once enough research is conducted, uranium shells are made available, which are equal or superior in all regards. Since regular shells are still specifically required to manufacture uranium variants, any previously manufactured stockpile can be "upgraded" without waste.\r\n\r\nWhile cannon shells still deal an amount of explosive damage, it is only dealt on the directly hit target and it is also a much lower amount than what explosive shells deal; its primary damage outlet is physical and therefore better suited against worms, nests and large spitters for their lesser resistances against it. It also features much greater piercing power that is reliable for up to medium-sized enemies.	100	8	Cannon_shell.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
156	Explosive cannon shell	explosive-cannon-shell	combat	The explosive cannon shells are the basic ammunition for the Tank along with cannon shells. Once enough research is conducted, explosive uranium shells are made available, which are equal or superior in all regards. Since regular shells are still specifically required to manufacture uranium variants, any previously manufactured stockpile can be "upgraded" without waste.\r\n\r\nExplosive cannon shells deal lower physical damage and their piercing power has practical use for only the smallest enemies. In turn, they make up for it with an even greater amount of explosive damage that is dealt to multiple targets within radius. The total amount of damage dealt on the shell is greater than its physical counterpart, but it must be noted that worms, nests and especially spitters have considerable explosive resistance that well compensate for this damage increase. However, thanks to the greater raw numbers, upgrades have greater impact on the shells' potential, and their area-of-effect proves valuable later on in the game.	100	8	Explosive_cannon_shell.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
162	Explosive rocket	explosive-rocket	combat	Explosive rockets are ammunition for the rocket launcher and the spidertron. They have high range and damage which makes them perfect for attacking enemy buildings. While the total base damage is only 150 vs the 200 from a standard rocket, 100 of it is splash, which can be highly effective against groups of enemies. This is approximately triple that of a grenade.	100	8	Explosive_rocket.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
160	Radar	radar	combat	The radar reveals the map for the force it belongs to.\r\n\r\nIt can be used to provide a small area of remote vision on the map; it also allows periodic scanning of distant chunks around it. The radar has a high power demand (300kW) so a radar indirectly contributes to pollution when powered by boilers and steam engines. A radar can be continuously powered by eight solar panels and six accumulators. Seven solar panels and five accumulators is the most efficient; it gives the radar full power all but a short time in the morning, but never dips below the 20% power threshold for nearby scanning.\r\n\r\nDespite being categorized as a military building, the radar will not be attacked by enemies unless it blocks their path to another target, which means that radars can be safely placed in biter-infested areas without needing to be defended. The radar will show enemy lifeforms and structures, as well as trains, cars, and other players in the scanned area.	50	0.5	Radar.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
159	Artillery shell	artillery-shell	combat	The artillery shell is used as ammunition by artillery. It is a rather slow projectile that is shown on the map and explores every chunk as it travels to its target. It deals enough damage to destroy any enemy nest or worm within two shots.\r\n\r\nWhile artillery shells have a stack size of 1, they can stack up to 100 inside the inventory of the artillery wagon itself and up to 15 inside the artillery turret.	1	15	Artillery_shell.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
161	Rocket	rocket	combat	This article is about the explosive ammo for the rocket launcher. For the large end-game rocket silo, see Rocket silo.\r\nRockets are the common ammunition for the rocket launcher and the spidertron. They have high range and damage which makes them perfect for attacking enemy buildings.	100	4	Rocket.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
164	Cluster grenade	cluster-grenade	combat	The cluster grenade is an advanced grenade which has a slightly better range than the basic grenade, and splits into 7 basic grenades when impacting its target. Its damage can be increased further with research. Compared to the basic grenade, its increased blast radius makes it much better for clearing out dense areas, as well as swarms of enemies and enemy nests.	100	8	Cluster_grenade.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
165	Poison capsule	poison-capsule	combat	The poison capsule is a basic capsule that creates a large, long-lasting cloud of at the target area, dealing 8 poison damage twice a second, totaling to 320 poison damage over 20s. The damage from multiple poison capsules can stack. This is one of the most effective ways of removing trees.\r\n\r\nPoison capsules can be used to effectively kill worms as they are stationary. This technique is a relatively safe and cheap way to eliminate clusters of worms - it takes 5 poison capsules to kill a big Worm and the capsules can be thrown from outside the big Worm's spitting range. Since spawners are not affected by poison damage, poison capsules are useless against them.\r\n\r\nPoison capsules do not harm the player's structures, robots or vehicles, but do harm players themselves unless they are in a vehicle. Poison capsules are particularly effective when deployed from the tank, as the tank can park inside a cloud of poison to lure enemies to their death.	100	8	Poison_capsule.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
166	Slowdown capsule	slowdown-capsule	combat	The slowdown capsule is a basic capsule that, when thrown, will slow down all enemy movement within a wide radius of where it landed. Slowdown effect reduces movement speed by 75% for 30 seconds.	100	8	Slowdown_capsule.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
169	Destroyer capsule	destroyer-capsule	combat	Destroyer capsules are advanced and expensive capsules that, when thrown with the right mouse button, spawn five powerful Destroyer robots. The Destroyer robots have infinite electrical energy and will follow the player, attacking any enemies that come within range, until they run out of health or their lifespans elapse.	100	15	Destroyer_capsule.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
170	Light armor	light-armor	combat	Light armor is the most basic craftable armor type. It provides considerable protection against the smallest of biters, effectively reducing their 7 damage to 4. Light armor struggles to protect against larger biters and offers almost no protection against spitters or worms.	1	3	Light_armor.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
171	Heavy armor	heavy-armor	combat	Heavy armor provides more protection than light armor, nearly nullifying the damage from small biters (from 7 damage to 0.7) as well as providing respectable protection from medium biters, spitters and worms. Additionally, it provides excellent protection against accidental self-inflicted damage from grenades.	1	8	Heavy_armor.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
172	Modular armor	modular-armor	combat	Modular armor offers a modest increase in acid resistance over its predecessor and a notable increase in explosion resistance, but its greatest bonus comes in the form of equipment modules. The Modular armor offers a 5×5 grid that can be customized with an assortment of modules for defense, support or attack. Right click on the armor to show the equipment grid.\r\n\r\nLeft clicking the equipped armor will pick it up and unequip it, eliminating its inventory bonus. If the player's inventory is too full to be contained without the extra inventory slots, removing the armor will fail with a message stating "Cannot remove armor. Insufficient inventory space if removed."	1	15	Modular_armor.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
173	Power armor	power-armor	combat	Power armor provides yet another increase in inventory and defense over modular armor, in addition to a larger 6×8 grid for equipment modules. Access the equipment grid by right-clicking on the armor.\r\n\r\nEquipping the armor adds 20 slots to the player's inventory. As with all modular armor, taking off the armor will remove the inventory bonus, and any items in the extra inventory slots will prevent the player from unequipping the armor.	1	20	Power_armor.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
174	Power armor MK2	power-armor-mk2	combat	Power armor MK2 is the strongest power armor in the base game. It has increased resistances over basic power armor and a 10×10 equipment grid, making it larger than the grid of the spidertron. Access the equipment grid by right-clicking on the armor.\r\n\r\nEquipping the armor adds 30 slots to the player's inventory (in normal quality). As with all modular armor, taking off the armor will remove the inventory bonus, and any items in the extra inventory slots will prevent the player from unequipping the armor.	1	25	Power_armor_MK2.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
175	Portable solar panel	solar-panel-equipment	combat	Portable solar panels are the basic power generating units for modular armor and the spidertron. They provide only a small amount of power, and only during the daytime.\r\n\r\nPortable solar panels can be used to slowly recharge energy shields out of combat, but are nearly useless for personal laser defense or exoskeleton, even with a large number of batteries.\r\n\r\nPortable solar panels are 1×1 in size and are therefore primarily used in modular armor, which has a 5×5 grid that cannot usefully hold a much more powerful 4×4 portable fission reactor.	20	10	Portable_solar_panel.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
176	Portable fission reactor	fission-reactor-equipment	combat	Portable fission reactors are advanced power generating modules for modular armor, power armor, power armor MK2 and the spidertron. They generate 750kW of power, equivalent to 25 portable solar panels, while taking up only a 4×4 area in the equipment grid.\r\n\r\nPortable fission reactors are an unlimited source of energy and require nothing to power them.\r\n\r\nPortable fission reactors are essential items for power armor and power armor MK2, as running the many other modules in these armors would take far too many solar panels to be practical.	20	10	Portable_fission_reactor.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
177	Personal battery	battery-equipment	combat	The personal battery provides a basic 20MJ power storage for modular armor, the tank and the spidertron. They are also components in creating the improved personal battery MK2.	20	10	Personal_battery.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
178	Personal battery MK2	battery-mk2-equipment	combat	The personal battery MK2 provides 100MJ power storage for modular armor, the tank and the spidertron. This type is an improved version of the personal battery as it provides five times more capacity per size.	20	10	Personal_battery_MK2.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
179	Belt immunity equipment	belt-immunity-equipment	combat	The belt immunity equipment, once inserted into modular armor or a vehicle with an equipment grid, grants the player or vehicle the ability to be on transport belts without being moved around by them. The belt immunity equipment always consumes power, even when the player or vehicle is not on a belt.	20	10	Belt_immunity_equipment.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
187	Laser turret	laser-turret	combat	Laser turrets are an advanced defense building with longer range than the gun turret, laser damage, and use electricity to operate instead of ammo (and a smaller amount of energy when idle). Each shot costs 800kJ of energy; as the shooting speed increases through upgrades, so does the power required to keep firing.\r\n\r\nUsing laser turrets to ward off attacks can cause electricity usage spikes, these can be offset by using accumulators (or steam storage and excess steam turbines).	50	20	Laser_turret.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
181	Personal roboport	personal-roboport-equipment	combat	The personal roboport allows the player to act as a mobile roboport when this item is placed in their equipped armor or the spidertron. It can be toggled on or off via a button in the shortcut bar or with ALT + F. The roboport's internal energy buffer must be 20% full to allow construction robots to deploy. They are also used to create the upgraded version of itself, the personal roboport MK2, which provide a higher robot limit.\r\n\r\nIf the personal roboport is disabled via the shortcut bar while any of the player's robots already out of the inventory and performing a task, they will continue to finish their tasks before returning to the player.	20	10	Personal_roboport.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
182	Personal roboport MK2	personal-roboport-mk2-equipment	combat	The personal roboport MK2 allows construction bots to work from the player's inventory. The personal roboport MK2 supports significantly more robots than the personal roboport (25, versus 10 for the MK1), a larger construction area (40×40 rather than 30×30), and extra charging ports (4 instead of 2). Inserting multiple of either roboport into the player's modular armor or the spidertron increases the number of supported robots, size of construction area and number of charging ports on a linear scale.\r\n\r\nIt can be toggled on or off via a button in the shortcut bar or with ALT + R. The roboport's internal energy buffer must be 20% full to allow construction robots to deploy. If the personal roboport is disabled via the shortcut bar while any of the player's robots already out of the inventory and performing a task, they will continue to finish their tasks before returning to the player.\r\n\r\nIf a personal robot runs out of energy it will reduce its speed and continue to try and catch up with the player.	20	20	Personal_roboport_MK2.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
184	Energy shield	energy-shield-equipment	combat	The energy shield generates a basic protective shield that can absorb a small amount of damage.\r\n\r\nEquipment modules can be used by placing them in the grid that opens by right clicking the armor.\r\n\r\nThe shield is effectively an extension of HP and has to be brought to 0 for the character to suffer any actual HP damage. Like actual HP, it benefits from the damage reduction attributes of its armor. All damage is split equally between shields, allowing all shields to recharge simultaneously. Energy shields are largely obsoleted by the Energy shield MK2, which offers a vastly increased HP buffer at the cost of demanding more energy per HP.\r\n\r\nA shield's maximum recharge rate is based on its energy draw divided by the energy cost per shield point. At 240kW costing 20KJ per shield point, the energy shield MK1 recharges 12 HP per second and takes 4 seconds to recharge from 0 to 50HP. The overall energy demand is extremely high and will stress the suit's solar panels and fusion reactor, so use batteries to maintain your shields under fire.\r\n\r\nMk1 shields have an internal energy buffer of 120kJ, which effectively provide an additional hidden 6HP of shielding and add an extra .5 seconds to fully recharge.	20	10	Energy_shield.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
185	Energy shield MK2	energy-shield-mk2-equipment	combat	The energy shield MK2 generates a stronger protective shield around the character, absorbing some damage.\r\n\r\nThe shield is effectively an extension of HP and has to be brought to 0 for the character to suffer any actual HP or armor damage. Like actual HP, it benefits from the armor's damage resistance. A cheaper version of it is the energy shield.\r\n\r\nA shield's maximum recharge rate is based on its energy draw divided by the energy cost per shield point. At 360kW costing 30KJ per shield point, the energy shield MK2 recharges 12 HP per second and takes 12.5 seconds to recharge from 0 to 150 HP. All damage is split equally between shields, allowing all shields to recharge simultaneously.\r\n\r\nThe maximum shield recharge rate is limited by the suit's energy supply. A portable fission reactor will only sustain 2 MK2 shields under fire (or 3 MK1 shields) while portable solar panels are only good for a few recharges per day. Because of the high energy demand, it can be useful to complement shields with modular batteries, as they will maintain shield recharge under fire.\r\n\r\nThe Energy Shield Mk2 has an internal energy buffer of 180kW, which effectively adds a hidden 6HP and additional .5 seconds to recharge.	20	10	Energy_shield_MK2.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
188	Discharge defense	discharge-defense-equipment	combat	The discharge defense provides an emergency self defense system when it is inserted into modular armor and the spidertron. When triggered by left-clicking with the discharge defense remote it pushes back, stuns, and damages enemies around the player.	20	10	Discharge_defense.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
189	Gate	gate	combat	Gates are a variant of walls that act as a safe opening in walls that only the player can use. Gates can be placed as parts of walls, and have the same strength as a wall. Multiple gates placed adjacent to each other will merge into a single longer gate. They can also be placed over rails to create train gates.	50	0.5	Gate.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
191	Gun turret	gun-turret	combat	Gun turrets are defensive structures and are the first automatic defense to be unlocked. They use magazines for ammunition which can be refilled manually or by inserters. Unlike laser turrets, they do not require power and can operate practically anywhere as long as they have sufficient ammunition. On the downside, this means that ammo must be periodically replenished.\r\n\r\nThe gun turret has the same fire rate as the human-portable submachine gun. Physical projectile damage (research) upgrades both the base damage of the ammunition and the damage of the turret as two separate, multiplicative bonuses, quickly leading to a much higher damage output than the SMG.\r\n\r\nInserters can insert and remove magazines from gun turrets. This allows chaining multiple turrets together with inserters, each inserter taking ammo, as needed, from one turret and placing it into the next. Inserters will only insert up to 10 magazines per turret.	50	8	Gun_turret.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
192	Flamethrower turret	flamethrower-turret	combat	Flamethrower turrets work similarly to the flamethrower, setting enemies and the ground on fire and doing damage over time. Unlike gun turrets and laser turrets, they have a limited firing arc, and should therefore be placed at choke points or behind walls. They can use crude, heavy, or light oil as ammunition, which must be provided via a pipe connected to the turret.	50	20	Flamethrower_turret.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
194	Spidertron	spidertron	logistics	The spidertron is a versatile lategame vehicle capable of traversing rough terrain. It, along with the car and tank, is one of three non-rail vehicles in Factorio. It's equipped with four fast-firing rocket launchers capable of manual or automatic targeting. It can be driven manually or remotely controlled using the spidertron remote. Furthermore, it has an equipment grid which accepts all equipment modules. Spidertron's legs can be moved by belts which can be prevented by inserting belt immunity equipment into its equipment grid.\r\n\r\nThe vehicle can be renamed, and its color can be changed independently of the color of the player that is riding inside it. This color and name are shown in the tooltip of all connected spidertron remotes. Additionally, the spidertron's inventory can have logistics requests and auto-trash filters set up, similar to the player inventory, so the vehicle is automatically supplied by logistic robots.\r\n\r\nPicking up the vehicle keeps the modules inside its equipment grid, its name, its color and the logistics requests saved in the item, however any content from the spidertron's inventory is placed into the player's inventory and not saved in the item.	1	10	Spidertron.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
1	Wood	wood	items	Wood is a basic resource that can be collected by harvesting trees. Wood can be used in crafting recipes but can also be used as fuel in all burner devices as well as in cars, tanks and locomotives. The player starts with 1 wood when starting a freeplay game.\r\n\r\nDead trees will give 2 wood.\r\nBig trees will give 4 wood.	100	0.5	Wood.png	[]
9	Water	water	items	Water is a liquid which can be infinitely extracted from water tiles using an offshore pump.\r\nWater can be used to generate electricity by converting it to steam via boilers or heat exchangers. The specific heat capacity of water is 2kJ / Δ°C / unit. However, one unit of water converts to ten units of steam, which has a heat capacity of 200J / Δ°C / unit. That is, it takes 200 joules to heat one unit of steam by one degree Celsius. Water is also used as an ingredient in various recipes.\r\nSurface water acts as an obstacle that cannot normally be traveled over.\r\nRaw fish are spawned in water tiles during world generation only, and do not reproduce naturally. Water tiles can be removed completely by placing landfill over them. Pollution will turn nearby water green, which is a visual-only effect (the effect can be turned off by disabling animated water in the graphics settings). The color changes relative to the current amount of pollution around it, so decreasing pollution purifies the water.	50	0.5	Water.png	["Offshore pump"]
17	Sulfur	sulfur	items	Sulfur is a component in the production of Chemical science pack, Sulfuric acid and Explosives, with the latter two also being intermediate products used in higher-level recipes.\r\n\r\nSulfur is a solid item in a chain of otherwise fluid-based manufacturing: Crude oil → Petroleum gas → Sulfur → Sulfuric acid.	50	1	Sulfur.png	["Chemical plant"]
20	Copper ore	copper-ore	items	Copper ore is a basic resource found in resource patches throughout the world. It can be smelted into copper plates in a furnace.\r\n\r\nCopper ore is the main source of copper plates, which are one of the two principal raw materials (along with iron plates, made from iron ore) for crafting the vast majority of items in the game. In the early game, copper is needed in smaller quantities than iron, with some early-game products not requiring it at all. Demand for copper increases considerably in the mid- and late-game, where it (mostly in the form of copper cables) is required mainly for the assembly of electronic circuits and the myriad products those are required in, and for low density structures.\r\n\r\nThe size, density, and richness of copper patches can, as for all other resources, be adjusted upon map generation at the start of a new game. Like all resource patches, copper patches increase in richness with increasing distance from the starting area.	50	1	Copper_ore.png	["Burner mining drill", "Electric mining drill", "Player"]
30	Fill heavy oil barrel	fill-heavy-oil-barrel	items	Filled barrels cannot be crafted. They are filled using the respective fluids's Fill barrel process which consumes empty barrels.	10	0.2	Fill_heavy_oil_barrel.png	["Assembling machine 2", "Assembling machine 3"]
199	Electric mining drill	electric-mining-drill	production	The electric mining drill mines out iron ore, copper ore, uranium ore, stone and coal, and places it in front of the output tile, on a belt or in a machine or chest that covers the output tile.\r\n\r\nThe machine is 3×3, but mines in a 5×5 area, extending 1 tile away on each side. Mines copper ore, iron ore, coal, or stone at a rate of 0.5/s and uranium ore at a rate of 0.25/s.\r\n\r\nWhen placed over uranium ore, which requires sulfuric acid to mine, three fluid connectors will appear on the mining drill. The mining drills will pass excess sulfuric acid to each other when these connectors are aligned, allowing multiple drills to be placed right next to each other with only one pipe input necessary to feed all of them.	50	2	Electric_mining_drill.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
196	Satellite	satellite	items	The satellite is used in the creation of space science packs in the rocket silo. The crafted satellite must be placed into the rocket before launch, otherwise the rocket will not launch. Only one satellite is necessary per rocket launch. A satellite will yield 1000 space science packs after being consumed by a rocket launch, which will be delivered to the cargo landing pad. A cargo landing pad must be built somewhere on the planet for a rocket to launch.	1	5	Satellite.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
197	Flamethrower ammo	flamethrower-ammo	combat	This ammunition is used for the flamethrower. Currently this is the only available type of flamethrower ammunition. One flamethrower ammo item lasts 1.66 seconds (100 ticks).\r\n\r\nNote that flamethrower turrets use oil directly instead of this ammo.	100	6	Flamethrower_ammo.png	["Chemical plant"]
39	Electronic circuit	electronic-circuit	items	The electronic circuit (or "green circuit") is a basic intermediate product, widely used throughout the game. The electronic circuit is the first in a line of circuit-type intermediate products.\r\n\r\nElectronic circuits are used as an ingredient for many item recipes, including creation of all kinds of inserters, and most production machines such as assemblers, solar panels and electric mining drills. Certain other logistic devices will also need electronic circuits to be created, such as rail signalling equipment. The logistic network is also incredibly dependent on products constructed with these circuits.\r\n\r\nElectronic circuits need to be made in order to produce the upgraded variants of circuit such as the advanced circuits and processing units. Combined together, these circuits can also make modules.\r\n\r\nThe ratios of assembling machines of the same tier to craft this item are:\r\n\r\nNormal mode\r\n3 Copper cable assembling machines → 2 Electronic circuit assembling machines\r\nExpensive mode\r\n4 Copper cable assembling machines → 1 Electronic circuit assembling machine	200	0.5	Electronic_circuit.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
60	Grenade	grenade	combat	The grenade is a basic explosive weapon that is throw-able within a short distance, dealing damage in a small area of effect. It is effective against small biters and small spitters. Its damage can be increased with research. Grenades can also be used as an ingredient to craft the more powerful cluster grenade.\r\n\r\nAdditionally, the grenade's decent blast radius allows it to quickly clear out dense areas of structures or trees, and its low cost makes it ideal for quick early-game deforestation.	100	8	Grenade.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
63	Wall	stone-wall	combat	Walls are a defensive structure that prevents both the player and enemies from passing. They can be used to shield turrets so they will be able to fight enemies longer without being destroyed, and can be used to protect parts of the factory from enemies. Although walls have less health than most defensive structures, their high damage resistance means it will take longer for enemies to destroy them.\r\n\r\nGates can be constructed to allow the player to pass through walls. Gates share the same health and resistances as walls and automatically close for enemies if not connected to the circuit network, so no defensive power is lost.\r\n\r\nWalls only block melee attacks, projectile attacks go over them. However, big and behemoth biters can attack 2 tiles away, meaning they can hit structures directly behind a single layer of walls. To prevent this, structures can be moved further back from the walls or a second layer of walls can be added.\r\n\r\nDespite their applications as a defensive measure, walls are not considered a military unit and structure; this is important for understanding the behavior of enemies regarding walls. If they are attempting to attack something and the wall obstructs their path, they will attack the wall to destroy it and clear the way. However, if they have already been aggro'd by a turret or the player, enemies will more actively pursue their aggressor and not necessarily attack walls between them. This allows the player to stall enemies more efficiently by building walls in a manner that disrupts their pathing without entirely obstructing it. However, if their pathing is disrupted enough, they will still resort to attacking the wall to remove the obstruction, thus long sections of wall that enemies will chew through may be less effective than shorter segments that force them to go around.\r\n\r\nPlacing walls in four adjacent tiles forming a square will cause the inner space to be filled. This is only a visual property, the health and the rest of the properties of the walls are not affected.	100	0.5	Wall.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
72	Express transport belt	express-transport-belt	logistics	Express transport belts are a faster variant of the transport belt, operating at triple speed. In the base game, they are the third and final tier among the transport belts.\r\n\r\nUnlike previous tiers, express transport belts rely on oil processing for lubricant.	100	0.5	Express_transport_belt.png	["Assembling machine 2", "Assembling machine 3"]
79	Burner inserter	burner-inserter	logistics	The burner inserter is the most basic and slowest type of inserters. It is powered by burning fuel, compared to the more advanced inserters which are powered by electricity. It will add fuel to its own supply if it picks any up, which makes it useful for filling boilers with coal. This has the advantage that it will continue working even if the power fails, as opposed to electrically-powered inserters which will be unable to function. It consumes no fuel while idle, though it consumes vastly more energy than most other inserters when active.\r\n\r\nEven though it doesn't use electricity, a burner inserter can be connected to and controlled by the logistic and the circuit network.\r\n\r\nBurner inserters, like all inserters, do not directly produce any pollution in their operation. However, burner inserters can still indirectly contribute to pollution by consuming fuel, which costs pollution to gather.	50	0.5	Burner_inserter.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
85	Big electric pole	big-electric-pole	logistics	The big electric pole is an improved electric pole. It is a more specialized variant compared to the medium electric pole, offering the longest wire reach of all of the electric poles, with the trade-off of a very short supply area. Because of this, big electric poles are ideal for long-distance power lines, as they require the smallest number of entities to be placed to span a given distance, but generally unsuitable for providing local coverage to groups of structures. It can also carry signals for the circuit network.	50	0.5	Big_electric_pole.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
91	Locomotive	locomotive	logistics	The Locomotive is the engine for movement of trains over tracks. Trains are useful for moving large amounts of items over large distances. With the Space Age expansion, locomotives can also utilize elevated rails, which are rails built off of a rail ramp, allowing trains to freely drive over obstacles on the ground.\r\n\r\nLocomotives are also good vehicles for the player to reach fixed destinations, as they are considerably faster than the car or tank. Naturally, they do not have the same freedom of movement, as they are confined to the track. They can be set up to travel automatically between train stops, or be controlled manually, even if the player is in a cargo wagon attached to the train instead of the locomotive itself. Automatic trains can also use rail signals and rail chain signals to designate different or changing paths on a railway, as well as manage multiple trains on multiple or intertwining tracks.\r\n\r\nLocomotives are burner devices and require fuel to run; the more powerful the fuel used, the faster the locomotive's acceleration and top speed will be. Solid fuel, rocket fuel and nuclear fuel will give +20%, +80% and +150% acceleration respectively, and provide +5%, +15% and +15% for top speed respectively. Multiple locomotives can be used on a single train to increase its speed. If a locomotive has no fuel, it can still be moved manually, albeit very slowly.\r\n\r\nWhile locomotives can be assembled by hand, the engine unit for it requires automated construction to build, so it cannot be built from raw materials by hand. The color of the locomotive can be customized.	5	4	Locomotive.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
95	Car	car	logistics	The car is the earliest alternate form of transportation available to the player, and is one of three non-rail vehicles in Factorio; the others being the tank and the spidertron. Although it requires fuel, driving a car is much faster than running, letting the player scout out areas or outmaneuver enemies. Cars have a vehicle machine gun that has a 50% higher rate of fire and can fire two tiles farther than the submachine gun, 80 slots of storage and 450 health, allowing the player to use hit-and-run tactics against small groups of enemies.\r\n\r\nCars can collide with objects. Both the car and the object collided with may take damage. The damage is dependent on the speed of the car and the health of the target; small biters and trees can be safely rammed but colliding with big biters can easily destroy the vehicle and its contents. If the car is destroyed, its inventory is destroyed with it, though the player gets ejected and not killed.\r\n\r\nIn multiplayer, it is possible for a player to enter a car alongside another player. The passenger can take control of the weapons of the car using a switch in the GUI of the car, but cannot steer the car. Cars will take on the color of the player who drove it last.\r\n\r\nCars are moved by transport belts and inserters can interact with them. Because of that, cars may be used as large chests or as another mean of transportation besides belts, trains and robots.	1	2	Car.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
99	Active provider chest	active-provider-chest	logistics	The active provider chest is a large advanced storage item that is part of the logistic network. Logistic robots will pick up items from this chest to move them to requester chests, buffer chests, the player, or storage chests. Logistic robots will actively attempt to move all items within an active provider chest to storage chests when there are no other tasks available.\r\n\r\nActive provider chests have the highest priority as pick-up points for logistic robots when fulfilling requests.\r\n\r\nThe main use-case for active provider chests is to be the output for a production building or process that cannot afford to back up due to outputs not being consumed fast enough. One clear example is with nuclear reactors. A reactor will not start a new cycle if its output is not cleared of depleted uranium fuel cells. By putting them in an active provider chest, logistics robots will frequently remove such cells, ensuring that the chest will only fill up if there is insufficient logistics storage for such fuel cells.\r\n\r\nActive provider chests are designed to be emptied. If the player does not want the contained items to be moved until they are specifically requested, then the passive provider chest or buffer chest can be used instead	50	0.5	Active_provider_chest.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
101	Storage chest	storage-chest	logistics	The storage chest is a large advanced storage item that is part of the logistic network. Logistic robots store any items taken out of the player's logistic trash slots here, as well as items picked up from active provider chests. Construction robots will use stored items to repair damaged entities and construct ghosts, as well as storing items picked up as a result of a deconstruction order; this includes the wood/stone/coal from trees & rocks which were in the way of a ghost placement, and any items in other chests or on belts or inside buildings such as assembling machines when they are marked for deconstruction. Storage chests can be filtered to only accept one type of item from the logistic network.	50	0.5	Storage_chest.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
102	Buffer chest	buffer-chest	logistics	The buffer chest is a large advanced storage item that is part of the logistic network, and combines the functions of both a requester chest and a passive provider chest. The buffer chest's purpose is to be an "in-between" chest for ferrying items from provider chests to the player, construction robots, or requester chests.\r\nLike requester chests, buffer chests can be configured to request a specified number of up to 1000 types of items from the logistic network. Logistic robots will then bring the specified items from provider chests or storage chests until the request is met. In addition, similar to a passive provider chest, any items contained in a buffer chest are made available to construction robots, logistic requests from the player, and requester chests that have the "Request from buffer chests" checkbox checked. However, items in a buffer chest are not used to fulfill requests from other buffer chests.\r\n\r\nBy using SHIFT + Right mouse button and SHIFT + Left mouse button to copy-paste a recipe from an assembling machine to a buffer chest, the buffer chest is automatically configured to request enough ingredients for 30 seconds of continuous crafting.	50	0.5	Buffer_chest.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
104	Roboport	roboport	logistics	The roboport is the resting place for all construction robots and logistic robots. It emits an area of 50×50 tiles, in which logistic robots can interact with logistic network entities, such as storage chests, or requester chests. Additionally, a 110×110 tile area is created for construction robots to repair, construct or remove structures. These areas can be seen by hovering the mouse on a roboport, or logistics chest which is inside the logistic zone.\r\n\r\nThe smaller orange square represents the reach of the logistics network where both logistics and construction robots can move.\r\nThe larger green square represents the extent of the construction network where only construction robots can move.\r\nRobots placed into the air from the player's inventory inside of a roboport's coverage will seek out the nearest roboport to charge and rest.\r\n\r\nTwo or more roboports can connect to form a logistic network, if the borders of the orange logistic areas touch. This is shown by a dotted line running between the two ports. An example of this can be seen on the bottom-right. Non-connected roboports will not share robots.\r\n\r\nSimilar to the stationary radar's nearby scanning, a roboport constantly reveals an area of 5×5 chunks, centered on the chunk the roboport occupies.	10	5	Roboport.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
117	Landfill	landfill	logistics	Landfill can be used to replace water with usable land, regardless of the type of surrounding terrain. Landfill is placed using Left mouse button and the area in which it is placed can be increased and decreased by using Numpad + and Numpad -. Land-filled area is indistinguishable from normal terrain in terms of mechanics; it can be normally built and walked over. Once an area has been filled, the landfill can be removed by holding Right mouse button with landfill in the cursor. Construction robots will remove landfill marked for deconstruction with a deconstruction planner.\r\n\r\nWith the use of construction robots, landfill can automatically be placed below ghost buildings planned on water.\r\n\r\nNote that placing a landfill where raw fish are swimming will "destroy" them without being collected.	100	0.5	Landfill.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
108	Selector combinator	selector-combinator	logistics	The selector combinator can select a signal to output from one of the following modes of operation:\r\n\r\nSelect input:\r\nIn this mode, the combinator sorts its input signals by value and outputs one of them at the same value.\r\nSort descending (default): The signal with the highest value is selected.\r\nSort ascending: The signal with the lowest non-zero value is selected.\r\nIndex: Determines which position among the sorted values is selected, starting at 0, i.e. first (0), second (1), third (2).\r\nIf multiple signals are provided and index is out of bounds, then no signal is passed through. The valid bounds is 0 through 1 less the total quantity of input signals.\r\nIf a single input signal is provided, it is always passed through even if the index is out of bounds.\r\nCount inputs:\r\nThe combinator will count and output the number of unique inputs on the selected signal.\r\nThe value of the input signals is not considered.\r\nRandom input:\r\nThe combinator will pass through a random input signal every certain number of game ticks.\r\nBy default, the combinator will update this every 1 tick, or 60 times per second.\r\nIf there is only one input signal, it will be output after this threshold is met. If the input is removed before that happens, nothing will be output.\r\nStack size:\r\nThe combinator will output the stack sizes of the input items.\r\nThe combinator will not output any fluid or virtual signals.\r\nThe value of the input items is not considered.	50	0.5	Selector_combinator.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
118	Cliff explosives	cliff-explosives	logistics	Cliff explosives are used to blow up cliffs. The cliffs will not drop any items when blown up. These explosives can only be used on cliffs, as they can't be used at all when clicking on anything else. Cliff explosives will not damage anything else nearby.\r\n\r\nOnce cliff explosives have been researched, cliffs can be marked for deconstruction in the same way other environmental obstacles (rocks, trees, etc.) are. They will be queued for destruction by any construction robots in range, provided they have access to cliff explosives via the logistic network.	20	8	Cliff_explosives.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
120	Boiler	boiler	production	The boiler uses fuel to convert water into steam at 165°C suitable for use in a steam engine. It has two water connectors on opposite ends and passes water through to adjacent equipment such as other boilers. The boiler features a single output for the steam it produces. It only consumes fuel as it creates steam. Boilers used in conjunction with offshore pumps and steam engines are a vital part of early power generation.\r\n\r\nFor each unit of water, 10 units of steam are produced. Inserting one coal (4 MJ) into a boiler then using the resulting steam in a steam engine will supply 4 MJ of energy to an electrical system. It costs 300 kJ to heat 1 unit of water to into 10 steam at 165°C, so one boiler will produce 60 steam per second.\r\n\r\nInserters can insert fuel into boilers. However, using powered inserters to move fuel into a boiler can be problematic should fuel become unavailable: if no power is being produced, then powered inserters fueling a boiler cannot operate. Using at least one burner inserter, which uses fuel and not electricity, ensures that at least one inserter is available to restart a single boiler. Inserters can also remove fuel from boilers, allowing inserters to move fuel down a chain of boilers.	50	0.5	Boiler.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
122	Steam engine	steam-engine	production	Steam engines are the most basic electricity generator, available to the player at the start of the game. They produce electricity by consuming steam, using water pumped from an offshore pump that was heated to 165°C steam with boilers or to 500°C steam with heat exchangers. Steam that has a higher temperature than the maximum temperature of the steam engine (165°C) is consumed at the normal rate (30 units/s), and does not yield more electricity. This means the energy that was put into the steam to heat it to a higher temperature is wasted.\r\n\r\nSteam engines will automatically adjust their power production and steam usage based on the current demands of the electricity network. Hovering the mouse over a steam engine will display their current power production (Performance) and their possible power production (Available Performance), in a display on the right.\r\n\r\nSteam engines have two ports, allowing excess steam to flow through. This allows steam engines to be chained together. The current optimal ratio is 1 offshore pump to 200 boilers to 400 steam engines. For more information, see power production.\r\n\r\nUsing steam engines for power does not produce pollution, however using boilers to heat up the water does.	10	0.5	Steam_engine.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
146	Productivity module 3	productivity-module-3	production	Productivity module 3 applies a productivity bonus to items produced in a machine, allowing the machine to produce more items for the same inputs. It adds 10% productivity to the affected machine.\r\n\r\nProductivity modules can generally only be used to make intermediate products. These are items that are used in other recipes and cannot directly be placed.	50	60	Productivity_module_3.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
125	Nuclear reactor	nuclear-reactor	production	The nuclear reactor generates heat by burning uranium fuel cells. Heat can be consumed by heat exchangers to produce 500°C steam, which can be consumed by steam turbines to produce electricity.\r\n\r\nUnlike boilers, a nuclear reactor will continue to burn fuel regardless of heat consumption. A uranium fuel cells burns for 200 seconds. The maximum temperature of a nuclear reactor is 1000°C, and once reached, excess heat energy from the uranium fuel cell is wasted. To prevent wasting fuel, the temperature of a reactor can be read to a circuit network and used to enable fuel inserters only when the temperature is relatively low. More heat energy can be stored by placing extra heat pipes. Alternatively, energy can be stored as steam in storage tanks or as electricity in accumulators, which can also be read to control fuel inserters.\r\n\r\nRather than completely consuming fuel, burning a uranium fuel cell results in a depleted uranium fuel cell. These must be removed, else the reactor will stop consuming fuel. Depleted fuel cells can be reprocessed in a centrifuge to recover some uranium-238.\r\n\r\nNuclear reactors have a heat capacity of 10 MJ/°C. Thus, they can buffer 5 GJ of heat energy across their working range of 500°C to 1000°C, and require 4.85 GJ of energy to warm up from 15°C to 500°C when initially placed.	10	8	Nuclear_reactor.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
128	Steam turbine	steam-turbine	production	The steam turbine consumes steam to create electric energy. It is usually used together with heat exchangers and a nuclear reactor.\r\nWhile designed for the 500°C steam of a nuclear reactor, turbines can still be connected to boilers for use in conventional 165°C steam power. At this mode, the steam turbine acts equal to two separate steam engines, producing 1800 kW and consuming 60 steam/sec. However, actual power production is based on the temperature of the steam, not the building itself. This means that using a steam turbine is no more fuel-efficient than using two steam engines. Unless saving space within a large build, it is not necessary to use the more costly turbines for boiler steam.	10	0.5	Steam_turbine.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
134	Speed module	speed-module	production	Speed module increases a machine's speed by 20%, its energy consumption by 50%. This means that, at the cost of energy, the machine produces more items per minute.\r\n\r\nThe machine will consume more energy per second, but will also work more quickly. Because energy costs are based on time rather than number of operations, some of the increased energy cost is offset by the reduced time per operation.\r\n\r\nA speed module 1 requires a significant power increase for very little (less than half the standard rate) throughput increase, the worst amongst its group. By contrast a speed module 3 will produce a much better proportion of throughput, for a similar power requirement downside compared to this tier 1 speed module.\r\n\r\nThe quality bonus of any machine can never fall below 0, meaning speed modules cannot reduce the quality of a machine's output. The quality penalty only counteracts the effect of quality modules.\r\n\r\nSpeed modules also increase pollution, because it is directly proportional to the machine's power consumption, see pollution.	50	15	Speed_module.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
138	Lab	lab	production	Labs are buildings that perform research for technologies by consuming science packs. Use of a lab is required to progress in Factorio.\r\n\r\nWhen productivity modules are used in labs, the productivity bonus is directly calculated and applied each tick so the productivity bar is simply cosmetic. This means that it does not matter that the productivity bar resets when the research is changed, no productivity bonus is lost.\r\n\r\nThe player can only research one technology at a time, but can use multiple labs for faster results. The speed bonus of labs when lab research speed is researched and modules are present can be calculated using this formula: research_bonus × module_bonus = speed_bonus; the percentage bonuses have to be converted to decimals (e.g. +140% = 2.4) before the formula is used.\r\n\r\nInserters can insert and remove science packs from labs. This allows chaining multiple labs together with inserters, each inserter taking science packs, as needed, from one lab and placing it into the next.	10	2	Lab.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
147	Submachine gun	submachine-gun	combat	The submachine gun is an upgrade from the pistol. It fires the same ammunition types and deals the same damage as the pistol, but has a much higher rate of fire. This same type of weapon is installed in the car and tank; the car and tank's version of the submachine gun fires +5 rounds per second and has +2 range compared to the handheld one. This weapon can easily handle moderate waves of small biters, even with regular ammunition, but destroying nests efficiently requires damage upgrades or the more expensive piercing round.	5	10	Submachine_gun.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
148	Shotgun	shotgun	combat	The shotgun is a basic but powerful weapon with good range, damage, and ammunition efficiency, but a low rate of fire. It fires in a spread pattern. The shotgun will fire without hostile targets nearby, can damage walls (it won't shoot over them) and other friendly structures, thus requiring significantly more caution when used, compared to most other weapons.\r\n\r\nFor early Biter nests assaults, shotgun ammo represents a massive boost on resource efficiency, with 2 copper plates and 2 iron plates giving a stack of shotgun shells, dealing a total of 600 damage. Contrast this against the pistol's firearm magazine, which costs 4 iron plates and deals a total of 50 damage.\r\n\r\nThe shotgun is less effective in clearing out the biters themselves, because pellet spread will cause a nontrivial fraction of pellets to miss against small targets. Players can switch between the shotgun and submachine gun to balance power and resource-efficiency, or support themselves with covering fire from Turrets and combat bots.	5	10	Shotgun.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
157	Uranium cannon shell	uranium-cannon-shell	combat	The uranium cannon shells are an advanced ammunition type for the Tank along with explosive uranium cannon shells. Once they are made available, they surpass their regular variant; their damage and piercing power is increased twofold. Since regular shells are still specifically required to manufacture uranium variants, any previously manufactured stockpile can be "upgraded" without waste.\r\n\r\nWhile uranium cannon shells still deal an amount of explosive damage, it is only dealt on the directly hit target and it is also a much lower amount than what explosive shells deal; its primary damage outlet is physical and therefore better suited against worms, nests and large spitters for their lesser resistances against it. These shells also feature the greatest piercing power in the game that is reliable for anything but the largest enemies, even capable of destroying two nests in one shot.	100	12	Uranium_cannon_shell.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
158	Explosive uranium cannon shell	explosive-uranium-cannon-shell	combat	The explosive uranium cannon shells are an advanced ammunition type for the tank along with uranium cannon shells. Once they are made available, they surpass their regular variant; their damage and piercing power is increased, leaning more towards physical damage improvement. Since regular shells are still specifically required to manufacture uranium variants, any previously manufactured stockpile can be "upgraded" without waste.\r\n\r\nThe piercing power of the shells has little practical use in spite of its improvement, which can be made insignificant since the enemy may often "outgrow" it by the time this ammunition is obtained. Its raw damage advantage otherwise found in the non-uranium explosive shell is also no longer as substantial; because of the kinetic energy nature of uranium-based ammunition, uranium cannon shells receive a much greater improvement overall, "catching up" in terms of raw damage potential, making explosive shell use on explosive-resistant enemies like worms, nests and especially spitters even more discouraging. However, this imbalance can be limited through research, and its area-of-effect damage has undeniable benefits.	100	12	Explosive_uranium_cannon_shell.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
163	Atomic bomb	atomic-bomb	combat	Atomic bombs are very expensive alternative ammunition for the rocket launcher and the spidertron. They deal incredible damage over a wide area, capable of wiping out groups of enemies with ease. They can also kill even the most heavily-armored player, so they should be fired from a great distance.\r\n\r\nInstead of dealing all of its damage in a single explosion, the atomic bomb creates two waves of 1000 small, high-damage explosions in an expanding ring. One wave of explosions expands to a radius of 7 with each of the 1000 explosions dealing 100 damage in a radius of 3. The second wave of explosions expands to cover a radius of 35 and each of the 1000 explosions deals 400 damage in a radius of 3. This results in high damage at the center of the atomic bomb, which decreases towards the edge of the 35-tile radius.\r\n\r\nThe impact of the atomic bomb creates a black scorch mark in a 12-tile radius that never disappears and is visible from the map. All tiles in an oval approximately 24 tiles wide and 17 tiles high will be converted into nuclear ground, which affects pollution absorption and prevents the removal of any former landfill and foundation tiles in the blast radius. Furthermore, the atomic bomb will permanently destroy cliffs and decorative objects in a 9-14 tile radius around the center.	10	50	Atomic_bomb.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
180	Exoskeleton	exoskeleton-equipment	combat	Exoskeleton enhances the movement speed of the player by 30% when fully powered. It consumes 200kW (200kJ/s) of power when used. They can be toggled on and off in the shortcut bar, assuming the player is wearing one.\r\n\r\nExoskeleton is a kind of equipment module. It can be used by placing it in the grid that opens by right clicking the armor. Exoskeletons can also be placed into the equipment grid of vehicles like the spidertron and the tank to increase their movement speed. \r\nEach exoskeleton occupies a 2×4 tall rectangle in the equipment grid. It is possible to use multiple exoskeletons, and the speed bonus will stack additively. There is no speed limit; it is limited only by the amount of room available in the equipment grid and by available power.\r\n\r\nExoskeletons have a 56kJ internal electricity storage, visible as a charging bar. With no power, this will sustain them for less than a second. As the available power approaches 200kW, the charging bar will both drain more slowly and have a larger minimum size. The exoskeleton will provide a full speed bonus until the charging bar hits the minimum size, at which point the exoskeleton's speed bonus drops to what it can maintain. At 200kW or greater, the charging bar does not shrink and the speed bonus remains at maximum.\r\n\r\nNote that exoskeletons are below shields in armor charging priority, and if the shields are damaged at all, exoskeletons will rapidly run dry and will not resume their full speed until the shields are fully charged. This makes them fairly useless for quick getaways.	20	10	Exoskeleton.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
183	Nightvision	night-vision-equipment	combat	Nightvision is a kind of equipment module. It can be used by placing it in the grid that opens by right clicking the armor.\r\n\r\nHaving nightvision in the armor during the night changes the standard vision at night to be brighter with a slight grey overlay that drains non-lit areas of color. Unlike other items such as exoskeletons or shields, equipping multiple night vision units has no effect. Nightvision turns off and requires no energy during the day time.\r\n\r\nNightvision requires a suit energy supply to function. Unfortunately its complementary tech portable solar panel does not provide energy at night, and the Nightvision's internal buffer of 120 kJ will quickly drain in a few seconds. Getting initial use out of Nightvision requires charging a modular battery to stay online over night.\r\n\r\nWhen placed in a vehicle, the effects only work when the player enters or remote controls the vehicle.	20	10	Nightvision.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
186	Personal laser defense	personal-laser-defense-equipment	combat	The Personal laser defense is a module that can be inserted into modular armor, spidertrons, and tanks. It provides a basic laser defense system.\r\n\r\nIt automatically targets and fires at nearby enemies, and, unlike hand-held weapons, doesn't slow the player down when firing. It consumes power after it fires (to recharge), so it doesn't necessarily need personal batteries. Stacking multiple personal laser defenses in the modular armor provides more lasers to attack at once. Each shot costs 50kJ of energy; as the shooting speed increases through upgrades, so does the power required to keep firing.\r\n\r\nThe personal laser defense will fire at enemies nearby even if the player is inside a vehicle.	20	10	Personal_laser_defense.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
190	Land mine	land-mine	combat	Land mines are small, passive defense systems that explode when enemies come closer than 2.5 tiles of them, dealing 250 damage and stunning enemies for 3 seconds. Land mines can be placed freely on the map. They deal enough damage to kill small/medium enemies or unarmored players outright, but will only injure and stun larger enemies. Land mines do not damage allied buildings or players. They can be re-built by construction robots after exploding.\r\n\r\nAfter placing, land mines take 2 seconds to arm and bury in the ground. During those 2 seconds, they are visible to enemies and can be destroyed by biters or directly shot by enemy players. After burying, enemy land mines can only be destroyed using weapons with area damage, for example grenades or the flamethrower.\r\n\r\nLand mines are the only passive defense in Factorio; if an alien is hit by a land mine, they will not start chasing the player.	100	5	Land_mine.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
193	Artillery turret	artillery-turret	combat	The artillery turret is a super-long-range static defense structure added in game version 0.16. It fires artillery shells, relatively slow-moving projectiles that explore chunks of terrain they travel across. The turret has both automatic and manual (even longer-ranged) firing modes. Projectiles have sufficient damage to destroy any type of worm up to behemoths with a single hit, and have a modest area of effect. They can also one-shot spawners up to just below 75% evolution, since spawner health increases with evolution. Infinitely-stacking research upgrades are available for range, firing speed.\r\nThe artillery wagon is essentially the same weapon, only mounted on a train car and therefore mobile.\r\n\r\nInserters can insert and remove artillery shells from artillery turrets. This allows chaining multiple turrets together with inserters, each inserter taking shells as needed, from one turret and placing it into the next.\r\n\r\nThe artillery turret can be connected to the circuit network to read its current ammunition and/or enable it on a condition.	10	40	Artillery_turret.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
195	Rocket silo	rocket-silo	production	The rocket silo is an important production building that serves as the sole win condition and a source of space science packs in the base game.\r\nBuilding a silo requires, among other things, electric engine units, processing units, and concrete, which all must be produced in assembling machines or foundries and cannot be crafted by hand from raw materials. The rocket itself can only be produced in the silo.\r\nOnce the silo has been built and placed it can be filled with processing units, low density structure, and rocket fuel, which will create rocket parts within the silo. 100 rocket parts are needed to construct a rocket. The silo accepts productivity modules, and due to the high resource cost of rockets, silos are a prime candidate for their use. Once constructed, the rocket will rise into position and can be launched. It is required to place a cargo landing pad somewhere on the planet in order to launch a rocket.\r\n\r\nOnce a rocket has been constructed, the silo will continue to craft a second rocket within the silo. If both are constructed, once the first rocket has been launched, the second will rise into place without the silo going through its normal animation of closing and reopening its doors. This is particularly useful in Space Age when crafting speeds are faster and rockets are in increased demand.	1	30	Rocket_silo.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
198	Cargo landing pad	cargo-landing-pad	production	The cargo landing pad is a large storage structure that is part of the logistic network. It acts as an 8×8 passive provider chest with a capacity of 80 slots. Only one can be placed on the surface at a time. Inserters can pull items out of it like any other container, but cannot insert into the landing pad.\r\n\r\nWhen the rocket silo sends a rocket with a satellite into space, the cargo landing pad will receive 1,000 space science packs. If the landing pad is full, the science will be deposited on the ground and marked for deconstruction. The science will be delivered to the landing pad regardless of its distance from the rocket silo.\r\n\r\nThe landing pad can be connected to the circuit network to read its contents like other containers.	1	30	Cargo_landing_pad.png	["Assembling machine 1", "Assembling machine 2", "Assembling machine 3", "Player"]
\.


--
-- Data for Name: recipe_ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe_ingredients (id, product_id, ingredient_id, amount) FROM stdin;
663	75	74	2
664	75	36	80
665	75	14	40
666	76	39	5
667	76	4	5
668	76	58	4
669	77	39	10
670	77	36	10
671	77	76	1
672	78	40	10
673	78	77	1
674	78	36	10
675	78	14	80
676	79	36	1
677	79	4	1
678	80	57	1
679	80	36	1
680	80	4	1
681	81	39	2
682	81	57	1
683	81	4	2
684	82	40	1
685	82	39	15
686	82	81	1
687	82	36	15
688	83	38	2
689	83	1	1
690	84	38	2
691	84	37	4
692	84	7	2
693	85	38	4
694	85	37	8
695	85	7	5
696	86	4	5
697	86	43	10
698	87	42	1
699	87	43	1
700	87	7	1
701	88	39	5
702	88	4	6
703	88	37	6
704	88	7	3
705	89	39	1
706	89	4	5
707	90	39	1
708	90	4	5
709	91	39	10
710	91	42	20
711	91	7	30
712	92	36	10
713	92	4	20
714	92	7	20
715	93	36	10
716	93	43	8
717	93	7	16
718	93	8	1
719	94	40	20
720	94	42	64
721	94	36	10
722	94	43	16
723	94	7	40
724	95	42	8
725	95	4	20
726	95	7	5
727	96	40	10
728	96	42	32
729	96	36	15
730	96	7	50
741	168	40	3
742	168	167	4
743	101	40	1
744	101	39	3
745	101	6	1
746	102	40	1
747	102	39	3
748	102	6	1
749	103	40	1
750	103	39	3
751	103	6	1
752	104	40	45
753	104	36	45
754	104	7	45
755	105	38	3
756	105	39	1
757	105	4	1
758	106	38	5
759	106	39	5
760	107	38	5
761	107	39	5
762	117	19	50
763	108	40	2
764	108	107	5
765	109	38	5
766	109	39	2
767	110	38	5
768	110	39	2
769	110	4	5
770	111	38	5
771	111	39	4
772	111	4	3
773	111	37	4
774	112	39	1
775	112	4	1
776	113	3	1
777	113	64	5
778	113	9	100
779	114	113	10
780	115	113	20
781	115	37	8
782	115	7	1
783	115	9	100
784	116	115	10
785	118	28	1
786	118	27	10
787	118	60	1
788	119	39	2
789	119	36	2
790	121	19	5
791	120	43	4
792	120	121	1
793	122	36	8
794	122	4	10
795	122	43	5
796	123	23	5
797	123	39	15
798	123	7	5
799	124	26	5
800	124	4	2
801	143	40	5
802	143	41	5
803	143	142	4
804	144	40	5
805	144	41	5
806	144	143	4
807	145	40	5
808	145	41	5
809	145	67	4
810	146	40	5
822	128	23	50
823	128	36	50
824	128	43	20
811	146	41	5
812	146	145	4
813	125	40	500
825	129	36	3
826	129	4	3
827	129	121	1
814	125	113	500
815	125	23	500
816	125	7	500
817	126	23	20
818	126	7	10
819	127	23	100
820	127	43	10
821	127	7	10
828	130	7	6
829	130	64	10
830	131	39	3
831	131	36	5
832	131	4	9
833	132	131	1
834	132	39	3
835	132	36	5
836	132	7	2
837	133	132	2
838	133	134	4
839	134	40	5
840	134	39	5
841	135	39	10
842	135	36	10
843	135	43	10
844	135	7	15
845	135	64	10
846	136	39	5
847	136	36	5
848	136	43	5
849	136	7	5
850	137	40	100
851	137	113	100
852	137	36	100
853	137	7	50
908	159	156	4
909	159	27	8
910	159	160	1
911	161	27	1
912	161	4	2
913	162	27	2
914	162	161	1
915	163	27	10
916	163	41	10
917	163	49	30
918	164	27	5
919	164	60	7
920	164	7	5
921	165	18	10
922	165	39	3
923	165	7	3
924	166	18	5
925	166	39	2
926	166	7	2
927	169	168	4
928	169	134	1
979	188	187	10
930	170	4	40
931	171	23	100
932	171	7	50
933	172	40	30
934	172	7	50
935	173	44	20
936	173	41	40
937	173	7	40
938	174	143	25
939	174	44	40
940	174	46	30
941	174	41	60
942	174	140	25
943	175	40	2
944	175	123	1
945	175	7	5
946	176	46	50
947	176	41	200
948	176	51	4
949	177	26	5
950	177	7	10
951	178	177	10
952	178	46	5
953	178	41	15
954	179	40	5
955	179	7	10
956	187	26	12
957	187	39	20
958	187	7	20
959	180	44	30
960	180	41	10
961	180	7	20
962	181	40	10
963	181	26	45
964	181	36	40
965	181	7	20
966	182	46	20
967	182	181	5
968	182	41	100
969	183	40	5
970	183	7	10
971	184	40	5
972	184	7	10
973	185	184	10
974	185	46	5
975	185	41	5
976	186	187	5
977	186	46	5
978	186	41	20
980	188	41	5
981	188	7	20
982	189	39	2
983	189	7	2
984	189	63	1
985	190	27	2
986	190	7	1
987	191	23	10
988	191	36	10
989	191	4	20
990	192	42	5
991	192	36	15
992	192	43	10
993	192	7	30
994	193	40	20
995	193	113	60
996	193	36	40
997	193	7	60
998	194	144	2
999	194	180	4
1000	194	176	2
1001	194	46	150
1002	194	41	16
1003	194	160	2
1004	194	22	1
1005	194	150	4
1006	195	113	1000
1007	195	44	200
1008	195	43	100
1009	195	41	200
1010	195	7	1000
1017	196	124	100
1018	196	46	100
1019	196	41	100
1020	196	160	5
1021	196	47	50
1022	196	123	100
1023	197	11	100
1024	197	7	5
1025	198	113	200
1026	198	41	10
1027	198	7	25
1028	199	39	3
1029	199	36	5
1030	199	4	10
1031	57	36	1
1032	57	4	1
1033	57	39	1
854	138	39	10
855	138	36	10
856	138	58	4
857	139	40	20
858	139	38	10
859	139	39	20
860	139	7	10
861	140	40	5
862	140	41	5
863	140	134	4
864	141	40	5
865	141	41	5
866	141	140	4
867	167	39	3
868	167	36	3
869	167	62	3
870	142	40	5
871	142	39	5
872	147	23	5
873	147	36	10
874	147	4	10
875	148	23	10
876	148	36	5
877	148	4	15
878	148	1	5
879	149	23	10
880	149	36	5
881	149	7	15
882	149	1	10
883	150	39	5
884	150	36	5
885	150	4	5
886	151	36	10
887	151	7	5
888	152	62	1
889	152	50	1
890	153	23	2
891	153	4	2
892	154	23	5
893	154	153	2
894	154	7	2
895	155	27	1
896	155	25	2
897	155	7	2
898	156	27	2
899	156	25	2
900	156	7	2
901	157	155	1
902	157	50	1
903	158	156	1
904	158	50	1
905	160	39	5
906	160	36	5
907	160	4	10
731	97	40	2
536	4	3	1
537	5	4	8
538	7	4	5
539	8	4	20
540	8	7	5
541	12	9	50
542	12	11	100
543	13	11	100
544	13	9	50
545	14	12	10
546	15	11	100
547	2	1	2
548	17	9	30
549	17	15	30
550	16	4	1
551	16	17	5
552	16	9	100
553	23	20	1
554	24	15	20
555	25	18	1
556	25	15	20
557	26	4	1
558	26	23	1
559	26	16	20
560	27	18	1
561	27	17	1
562	27	9	20
563	28	7	1
564	29	28	1
565	29	11	50
566	30	28	1
567	30	24	50
568	31	28	1
569	31	13	50
570	32	28	1
571	32	14	50
572	33	28	1
573	33	15	50
574	34	28	1
575	34	16	50
576	35	28	1
577	35	9	50
578	36	4	2
579	37	4	1
580	38	23	1
581	39	38	3
582	39	4	1
583	40	38	4
584	40	39	2
585	40	25	2
586	41	39	20
587	41	40	2
588	41	16	5
589	43	4	1
590	42	7	1
591	42	36	1
592	42	43	2
593	45	39	3
594	45	44	1
595	45	7	1
596	45	26	2
597	44	39	2
598	44	42	1
599	44	14	15
600	46	23	20
601	46	25	5
602	46	7	2
603	47	13	10
604	47	24	10
605	48	46	10
606	48	47	10
607	48	41	10
608	49	21	1420
609	50	21	10
610	51	4	10
611	51	49	1
612	51	50	19
613	52	51	1
614	53	47	1
615	53	49	1
616	54	52	5
617	55	23	1
618	55	36	1
622	58	36	1
623	58	4	1
624	56	57	1
625	56	58	1
626	60	18	10
627	60	4	5
628	61	4	4
629	62	23	2
630	62	61	2
631	62	7	1
632	64	19	2
633	63	64	5
634	59	60	1
635	59	62	1
636	59	63	2
637	65	40	3
638	65	42	2
639	65	17	1
640	66	40	5
641	66	7	10
642	66	64	10
643	67	40	5
644	67	39	5
645	68	37	1
646	68	7	1
647	68	19	1
648	69	66	1
649	69	67	1
650	69	68	30
651	70	45	1
652	70	46	3
653	70	41	2
654	71	58	1
655	71	36	5
656	72	71	1
657	72	36	10
658	72	14	20
659	73	58	5
660	73	4	10
661	74	73	2
662	74	36	40
732	97	45	1
733	98	39	2
734	98	45	1
735	99	40	1
736	99	39	3
737	99	6	1
738	100	40	1
739	100	39	3
740	100	6	1
\.


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.items_id_seq', 199, true);


--
-- Name: recipe_ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recipe_ingredients_id_seq', 1033, true);


--
-- Name: items items_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_name_key UNIQUE (name);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: recipe_ingredients recipe_ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_pkey PRIMARY KEY (id);


--
-- Name: recipe_ingredients recipe_ingredients_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.items(id);


--
-- Name: recipe_ingredients recipe_ingredients_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.items(id);


--
-- PostgreSQL database dump complete
--

\unrestrict qCB2ZDaKbLN3vzc4geTc5H5A9RLhWuDBZzveYxzASf2229SsAiG27jO7xgN1PuN

