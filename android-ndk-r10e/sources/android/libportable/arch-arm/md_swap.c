/*
 * Copyright 2013, The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <portability.h>
#include <sys/types.h>

/*
 * REV and REV16 weren't available on ARM5 or ARM4.
 */
#if !defined __ARM_ARCH_5__ && !defined __ARM_ARCH_5T__ && \
    !defined __ARM_ARCH_5TE__ && !defined __ARM_ARCH_5TEJ__ && \
    !defined __ARM_ARCH_4T__ && !defined __ARM_ARCH_4__

uint16_t WRAP(__swap16md)(uint16_t x) {
    register uint16_t _x = (x);
    __asm volatile ("rev16 %0, %0" : "+l" (_x));
    return _x;
}

uint32_t WRAP(__swap32md)(uint32_t x) {
    register uint32_t _x = (x);
    __asm volatile ("rev %0, %0" : "+l" (_x));
    return _x;
}

#endif

