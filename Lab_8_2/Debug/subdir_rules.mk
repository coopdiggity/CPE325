################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
main.obj: ../main.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: "$<"'
	@echo 'Invoking: MSP430 Compiler'
	"C:/ti/ccsv8/tools/compiler/ti-cgt-msp430_18.1.2.LTS/bin/cl430" -vmsp --data_model=small -Ooff --use_hw_mpy=16 --include_path="C:/ti/ccsv8/ccs_base/msp430/include" --include_path="C:/Users/crc0031/Documents/cpe_325_code/Lab_8_2" --include_path="C:/ti/ccsv8/tools/compiler/ti-cgt-msp430_18.1.2.LTS/include" --define=__MSP430FG4618__ -g --c99 --printf_support=full --diag_warning=225 --diag_wrap=off --display_error_number --asm_listing --preproc_with_compile --preproc_dependency="main.d_raw" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


