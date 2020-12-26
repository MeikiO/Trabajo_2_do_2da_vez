public enum Coord {
	A8(0, true), B8(1, false), C8(2, true), D8(3, false),
	E8(4, true), F8(5, false), G8(6, true), H8(7, false),
	A7(8, false), B7(9, true), C7(10, false), D7(11, true),
	E7(12, false), F7(13, true), G7(14, false), H7(15, true),
	A6(16, true), B6(17, false), C6(18, true), D6(19, false),
	E6(20, true), F6(21, false), G6(22, true), H6(23, false),
	A5(24, false), B5(25, true), C5(26, false), D5(27, true),
	E5(28, false), F5(29, true), G5(30, false), H5(31, true),
	A4(32, true), B4(33, false), C4(34, true), D4(35, false),
	E4(36, true), F4(37, false), G4(38, true), H4(39, false),
	A3(40, false), B3(41, true), C3(42, false), D3(43, true),
	E3(44, false), F3(45, true), G3(46, false), H3(47, true),
	A2(48, true), B2(49, false), C2(50, true), D2(51, false),
	E2(52, true), F2(53, false), G2(54, true), H2(55, false),
	A1(56, false), B1(57, true), C1(58, false), D1(59, true),
	E1(60, false), F1(61, true), G1(62, false), H1(63, true),
	OFF_BOARD(-1, false);

	private int arrayIndex;
	private boolean isWhite;

	Coord(int arrayIndex, boolean isWhite) {
		this.arrayIndex = arrayIndex;
		this.isWhite = isWhite;
	}

	public int getArrayIndex() {
		return arrayIndex;
	}

	public boolean getIsWhite() {
		return isWhite;
	}
}
