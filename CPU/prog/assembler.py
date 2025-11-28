import sys

opcode = {
    "NOP": 0b0001,
    "ADD": 0b0010,
    "SUB": 0b0011,
    "AND": 0b0100,
    "OR": 0b0101,
    "MOV": 0b0110,
    "LOAD": 0b0111,
    "STORE": 0b1000,
    "JMPA": 0b1001,
    "JZ": 0b1010,
    "JNS": 0b1011,
    "JN": 0b1100,
    "HALT": 0b1101
}

regmap = {
    "R0": 0b001,
    "R1": 0b010,
    "R2": 0b011,
    "R3": 0b100
}

def assemble_line(line):
    parts = line.strip().replace(',', '').split()
    if not parts or parts[0].startswith(';'):
        return []
    instr = parts[0].upper()

    # Instrukcje rejestrowe: 2 rejestry
    if instr in ["ADD", "SUB", "AND", "OR", "MOV"]:
        dest = regmap[parts[1].upper()]
        src  = regmap[parts[2].upper()]
        byte = (opcode[instr] << 4) | (dest << 2) | src
        return [byte]

    # Instrukcje skoku: 1 bajt opcode + 1 bajt adresu
    elif instr in ["JMPA", "JZ", "JNS", "JN"]:
        addr = int(parts[1], 0) & 0xFF
        byte1 = (opcode[instr] << 4)
        return [byte1, addr]

    # Instrukcje pamięci: LOAD/STORE
    elif instr in ["LOAD", "STORE"]:
        reg = regmap[parts[1].upper()]
        addr = int(parts[2], 0) & 0xFF
        byte1 = (opcode[instr] << 4) | reg
        return [byte1, addr]

    # NOP (brak argumentów)
    elif instr == "NOP":
        return [(opcode[instr] << 4)]

    # HALF(zatrzymanie programu)
    elif instr == "HALT":
        return [(opcode[instr] << 4)]

    else:
        raise ValueError(f"Nieznana instrukcja: {instr}")

def main():
    if len(sys.argv) < 2:
        print("Użycie: python assembler.py program.asm")
        return

    lines = open(sys.argv[1]).read().splitlines()
    output = []
    for line in lines:
        output.extend(assemble_line(line))

    with open("program.hex", "w") as f:
        for b in output:
            f.write(f"{b:02X}\n")

    print("Gotowe! Wygenerowano program.hex")

if __name__ == "__main__":
    main()
