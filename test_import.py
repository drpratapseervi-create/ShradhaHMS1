import sys
sys.path.insert(0, r"C:\ShradhaHMS_Full\ShradhaHMS_Full")
try:
    import ShradhaHMS
    print("✅ Import ShradhaHMS OK ->", ShradhaHMS.__file__)
except Exception as e:
    print("❌ Import ShradhaHMS error:", e)
