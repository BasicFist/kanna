#!/usr/bin/env python3
"""
Test ChemLLM-7B Loading with 4-bit Quantization

Quick test to verify:
1. Model can be loaded with 4-bit quantization
2. VRAM usage is within acceptable range (<8GB)
3. Basic inference works

Usage:
  conda activate kanna
  python tools/scripts/test-chemllm-loading.py
"""

import torch
from transformers import AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig
import time
import sys

def main():
    print("="*60)
    print("ChemLLM-7B Loading Test")
    print("="*60)

    # Check CUDA
    if not torch.cuda.is_available():
        print("ERROR: CUDA not available!")
        sys.exit(1)

    print(f"GPU: {torch.cuda.get_device_name(0)}")
    print(f"Total VRAM: {torch.cuda.get_device_properties(0).total_memory / 1e9:.2f} GB")
    print(f"Free VRAM: {(torch.cuda.get_device_properties(0).total_memory - torch.cuda.memory_allocated(0)) / 1e9:.2f} GB")
    print()

    # Load model
    print("Loading ChemLLM-7B-Chat (this may take 5-10 min on first run)...")
    start_time = time.time()

    try:
        # Configure 4-bit quantization
        bnb_config = BitsAndBytesConfig(
            load_in_4bit=True,
            bnb_4bit_quant_type="nf4",
            bnb_4bit_compute_dtype=torch.bfloat16
        )

        # Load tokenizer
        print("Loading tokenizer...")
        tokenizer = AutoTokenizer.from_pretrained(
            "AI4Chem/ChemLLM-7B-Chat",
            trust_remote_code=True
        )
        print("✓ Tokenizer loaded")

        # Load model
        print("Loading model (downloading if first time)...")
        model = AutoModelForCausalLM.from_pretrained(
            "AI4Chem/ChemLLM-7B-Chat",
            quantization_config=bnb_config,
            device_map="auto",
            trust_remote_code=True
        )
        print("✓ Model loaded")

        load_time = time.time() - start_time
        vram_used = torch.cuda.memory_allocated() / 1e9

        print()
        print("="*60)
        print("LOADING SUCCESSFUL!")
        print("="*60)
        print(f"Load Time: {load_time:.1f} seconds")
        print(f"VRAM Used: {vram_used:.2f} GB")
        print(f"Model Device: {model.device}")
        print(f"Quantization: 4-bit (nf4)")
        print("="*60)

        # Test inference
        print("\nTesting inference...")
        test_prompt = """Fix this malformed chemistry formula:
Original: ( C 6 H 5
Context: Benzene ring structure
Category: general_chemistry

Provide only the corrected LaTeX formula:"""

        inputs = tokenizer(test_prompt, return_tensors="pt").to(model.device)

        with torch.no_grad():
            outputs = model.generate(
                **inputs,
                max_new_tokens=64,
                temperature=0.3,
                do_sample=True,
                top_p=0.9,
                use_cache=False  # Fix for quantized InternLM models
            )

        response = tokenizer.decode(outputs[0], skip_special_tokens=True)
        print(f"\nPrompt: {test_prompt[:80]}...")
        print(f"\nFull Response:\n{response}")
        print(f"\n✓ Inference test successful")

        print("\n" + "="*60)
        print("✅ ChemLLM-7B Ready for Validation")
        print("="*60)

        return 0

    except Exception as e:
        print(f"\n❌ ERROR: {e}")
        import traceback
        traceback.print_exc()
        return 1

if __name__ == "__main__":
    sys.exit(main())
