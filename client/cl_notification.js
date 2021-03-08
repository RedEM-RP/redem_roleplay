exports('DisplayLeftNotification', (title, subTitle, dict, icon, duration) => {

	const string1 = CreateVarString(10, "LITERAL_STRING", title);
	const string2 = CreateVarString(10, "LITERAL_STRING", subTitle);

	const struct1 = new DataView(new ArrayBuffer(48));
	struct1.setInt32(0, duration, true);
	struct1.setInt32(8, 0, true);
	struct1.setInt32(16, 0, true);

	const struct2 = new DataView(new ArrayBuffer(72));
	struct2.setBigInt64(8, BigInt(string1), true);
	struct2.setBigInt64(16, BigInt(string2), true);
	struct2.setBigInt64(32, BigInt(GetHashKey(dict)), true);
	struct2.setBigInt64(40, BigInt(GetHashKey(icon)), true);
	struct2.setInt32(48, 0, true);
	struct2.setInt32(56, 0, true);
	struct2.setInt32(64, 1, true);
	setTimeout(function () {
		Citizen.invokeNative("0x26E87218390E6729", struct1, struct2, 1, 1);
	}, 250);
});

exports('DisplayTopCenterNotification', (text, secondeText, duration) => {
	const struct1 = new DataView(new ArrayBuffer(48));
	struct1.setInt32(0, duration, true);

	const string = CreateVarString(10, "LITERAL_STRING", text);
	const string2 = CreateVarString(10, "LITERAL_STRING", secondeText);

	const struct2 = new DataView(new ArrayBuffer(24));
	struct2.setBigInt64(8, BigInt(string), true);
	struct2.setBigInt64(16, BigInt(string2), true);

	Citizen.invokeNative("0xD05590C1AB38F068", struct1, struct2, 1, 1);
});

exports('DisplayTip', (text, duration) => {
	const str = CreateVarString(10, "LITERAL_STRING", text);

	const struct1 = new DataView(new ArrayBuffer(48));
	struct1.setUint32(0, duration, true);

	const struct2 = new DataView(new ArrayBuffer(48));
	struct2.setBigUint64(8, BigInt(str), true);

	Citizen.invokeNative("0x049D5C615BD38BAD", struct1, struct2, 1);
});

// CREDITS: Mido#7092
