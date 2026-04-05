# DESIGN.md - 디자인 시스템

## 프로젝트 정보
- **서비스명**: 
- **버전**: 1.0.0
- **최종 수정**: 
- **디자인 도구**: Figma / 기타
- **UI 프레임워크**: shadcn/ui + Tailwind CSS
- **아이콘**: Lucide Icons

---

## 색상 팔레트

### Primary
| 토큰 | CSS Variable | Tailwind | 값 |
|-------|-------------|----------|-----|
| primary | `--primary` | `bg-primary` / `text-primary` | |
| primary-foreground | `--primary-foreground` | `bg-primary-foreground` | |
| primary-50 | `--primary-50` | `bg-primary-50` | |
| primary-100 | `--primary-100` | `bg-primary-100` | |
| primary-200 | `--primary-200` | `bg-primary-200` | |
| primary-300 | `--primary-300` | `bg-primary-300` | |
| primary-400 | `--primary-400` | `bg-primary-400` | |
| primary-500 | `--primary-500` | `bg-primary-500` | |
| primary-600 | `--primary-600` | `bg-primary-600` | |
| primary-700 | `--primary-700` | `bg-primary-700` | |
| primary-800 | `--primary-800` | `bg-primary-800` | |
| primary-900 | `--primary-900` | `bg-primary-900` | |

### Secondary
| 토큰 | CSS Variable | Tailwind | 값 |
|-------|-------------|----------|-----|
| secondary | `--secondary` | `bg-secondary` / `text-secondary` | |
| secondary-foreground | `--secondary-foreground` | `bg-secondary-foreground` | |

### Gray Scale
| 토큰 | CSS Variable | Tailwind | 값 |
|-------|-------------|----------|-----|
| gray-50 | `--gray-50` | `bg-gray-50` | |
| gray-100 | `--gray-100` | `bg-gray-100` | |
| gray-200 | `--gray-200` | `bg-gray-200` | |
| gray-300 | `--gray-300` | `bg-gray-300` | |
| gray-400 | `--gray-400` | `bg-gray-400` | |
| gray-500 | `--gray-500` | `bg-gray-500` | |
| gray-600 | `--gray-600` | `bg-gray-600` | |
| gray-700 | `--gray-700` | `bg-gray-700` | |
| gray-800 | `--gray-800` | `bg-gray-800` | |
| gray-900 | `--gray-900` | `bg-gray-900` | |
| gray-950 | `--gray-950` | `bg-gray-950` | |

### Accent
| 토큰 | CSS Variable | Tailwind | 값 |
|-------|-------------|----------|-----|
| accent | `--accent` | `bg-accent` | |
| accent-foreground | `--accent-foreground` | `text-accent-foreground` | |

### Semantic Colors
| 용도 | CSS Variable | Tailwind | 값 |
|------|-------------|----------|-----|
| success | `--success` | `bg-success` / `text-success` | |
| success-foreground | `--success-foreground` | `text-success-foreground` | |
| warning | `--warning` | `bg-warning` / `text-warning` | |
| warning-foreground | `--warning-foreground` | `text-warning-foreground` | |
| error / destructive | `--destructive` | `bg-destructive` / `text-destructive` | |
| error-foreground | `--destructive-foreground` | `text-destructive-foreground` | |
| info | `--info` | `bg-info` / `text-info` | |
| info-foreground | `--info-foreground` | `text-info-foreground` | |

### 배경 & 표면
| 토큰 | CSS Variable | Tailwind | 값 |
|-------|-------------|----------|-----|
| background | `--background` | `bg-background` | |
| foreground | `--foreground` | `text-foreground` | |
| card | `--card` | `bg-card` | |
| card-foreground | `--card-foreground` | `text-card-foreground` | |
| popover | `--popover` | `bg-popover` | |
| popover-foreground | `--popover-foreground` | `text-popover-foreground` | |
| muted | `--muted` | `bg-muted` | |
| muted-foreground | `--muted-foreground` | `text-muted-foreground` | |

---

## 타이포그래피

### 폰트 패밀리
| 용도 | CSS Variable | 폰트 |
|------|-------------|------|
| 본문 (sans) | `--font-sans` | |
| 제목 (heading) | `--font-heading` | |
| 코드 (mono) | `--font-mono` | |

### 타입 스케일
| 토큰 | 크기 | Line Height | Letter Spacing | Tailwind |
|-------|------|-------------|----------------|----------|
| xs | 0.75rem (12px) | 1rem | 0 | `text-xs` |
| sm | 0.875rem (14px) | 1.25rem | 0 | `text-sm` |
| base | 1rem (16px) | 1.5rem | 0 | `text-base` |
| lg | 1.125rem (18px) | 1.75rem | -0.01em | `text-lg` |
| xl | 1.25rem (20px) | 1.75rem | -0.01em | `text-xl` |
| 2xl | 1.5rem (24px) | 2rem | -0.02em | `text-2xl` |
| 3xl | 1.875rem (30px) | 2.25rem | -0.02em | `text-3xl` |
| 4xl | 2.25rem (36px) | 2.5rem | -0.02em | `text-4xl` |

### 폰트 굵기
| 토큰 | 값 | Tailwind | 용도 |
|-------|-----|----------|------|
| normal | 400 | `font-normal` | 본문 |
| medium | 500 | `font-medium` | 강조 텍스트, 레이블 |
| semibold | 600 | `font-semibold` | 소제목, 버튼 |
| bold | 700 | `font-bold` | 제목 |

---

## 간격 시스템

기본 단위: **4px**

| 토큰 | 값 | Tailwind | 용도 |
|-------|-----|----------|------|
| 0.5 | 2px | `p-0.5` / `m-0.5` | 미세 조정 |
| 1 | 4px | `p-1` / `m-1` | 아이콘-텍스트 간격 |
| 1.5 | 6px | `p-1.5` / `m-1.5` | 작은 내부 여백 |
| 2 | 8px | `p-2` / `m-2` | 컴팩트 내부 여백 |
| 3 | 12px | `p-3` / `m-3` | 기본 내부 여백 |
| 4 | 16px | `p-4` / `m-4` | 카드 내부 여백 |
| 5 | 20px | `p-5` / `m-5` | 섹션 내부 여백 |
| 6 | 24px | `p-6` / `m-6` | 넓은 내부 여백 |
| 8 | 32px | `p-8` / `m-8` | 섹션 간격 |
| 10 | 40px | `p-10` / `m-10` | 큰 섹션 간격 |
| 12 | 48px | `p-12` / `m-12` | 페이지 여백 |
| 16 | 64px | `p-16` / `m-16` | 히어로 섹션 여백 |
| 20 | 80px | `p-20` / `m-20` | 대형 여백 |

---

## 반응형 브레이크포인트

| 이름 | 범위 | Tailwind 접두사 | 컨테이너 최대 폭 |
|------|------|-----------------|-----------------|
| Mobile | < 640px | (기본) | 100% |
| Tablet | 640px - 1024px | `sm:` / `md:` | 768px |
| Desktop | 1024px+ | `lg:` / `xl:` / `2xl:` | 1280px |

### 브레이크포인트 사용 규칙
- **Mobile First**: 기본 스타일은 모바일, 큰 화면에서 오버라이드
- 640px (`sm`): 2열 그리드 시작
- 768px (`md`): 사이드바 표시 시작
- 1024px (`lg`): 전체 데스크톱 레이아웃
- 1280px (`xl`): 와이드 컨테이너
- 1536px (`2xl`): 초대형 화면 최적화

---

## 컴포넌트 규칙

### Button Variants
| Variant | 용도 | 클래스 |
|---------|------|--------|
| primary (default) | 주요 CTA | `<Button>` |
| secondary | 보조 액션 | `<Button variant="secondary">` |
| ghost | 텍스트 버튼, 네비게이션 | `<Button variant="ghost">` |
| destructive | 삭제, 위험한 액션 | `<Button variant="destructive">` |
| outline | 테두리만 있는 버튼 | `<Button variant="outline">` |
| link | 링크 스타일 버튼 | `<Button variant="link">` |

#### 버튼 크기
| Size | 높이 | 패딩 | 폰트 크기 |
|------|------|------|----------|
| sm | 36px | `px-3` | `text-sm` |
| default | 40px | `px-4 py-2` | `text-sm` |
| lg | 44px | `px-8` | `text-base` |
| icon | 40px | `p-2` | - |

### Card Variants
| Variant | 용도 | 스타일 |
|---------|------|--------|
| default | 일반 카드 | `bg-card` + `border` + `rounded-lg` |
| elevated | 강조 카드 | `bg-card` + `shadow-md` + `rounded-lg` |
| interactive | 클릭 가능 카드 | `hover:shadow-lg` + `transition-shadow` + `cursor-pointer` |
| outlined | 테두리 강조 | `border-2` + `rounded-lg` |

### Input Styles
| 상태 | 스타일 |
|------|--------|
| default | `border-input` + `bg-background` |
| focus | `ring-2` + `ring-ring` + `ring-offset-2` |
| error | `border-destructive` + `focus:ring-destructive` |
| disabled | `opacity-50` + `cursor-not-allowed` |

### Navigation Patterns
| 패턴 | 용도 |
|-------|------|
| Top Nav | 데스크톱 메인 네비게이션 |
| Side Nav | 대시보드, 관리자 페이지 |
| Bottom Tab | 모바일 메인 네비게이션 |
| Breadcrumb | 깊은 계층 구조 |

---

## 다크모드 토큰 매핑

```css
/* Light Mode (기본) */
:root {
  --background: 0 0% 100%;
  --foreground: 0 0% 3.9%;
  --card: 0 0% 100%;
  --card-foreground: 0 0% 3.9%;
  --primary: ;       /* 프로젝트에 맞게 설정 */
  --primary-foreground: ;
  --secondary: 0 0% 96.1%;
  --secondary-foreground: 0 0% 9%;
  --muted: 0 0% 96.1%;
  --muted-foreground: 0 0% 45.1%;
  --accent: 0 0% 96.1%;
  --accent-foreground: 0 0% 9%;
  --destructive: 0 84.2% 60.2%;
  --destructive-foreground: 0 0% 98%;
  --border: 0 0% 89.8%;
  --input: 0 0% 89.8%;
  --ring: ;          /* primary와 동일하게 설정 */
}

/* Dark Mode */
.dark {
  --background: 0 0% 3.9%;
  --foreground: 0 0% 98%;
  --card: 0 0% 3.9%;
  --card-foreground: 0 0% 98%;
  --primary: ;       /* 프로젝트에 맞게 설정 */
  --primary-foreground: ;
  --secondary: 0 0% 14.9%;
  --secondary-foreground: 0 0% 98%;
  --muted: 0 0% 14.9%;
  --muted-foreground: 0 0% 63.9%;
  --accent: 0 0% 14.9%;
  --accent-foreground: 0 0% 98%;
  --destructive: 0 62.8% 30.6%;
  --destructive-foreground: 0 0% 98%;
  --border: 0 0% 14.9%;
  --input: 0 0% 14.9%;
  --ring: ;          /* primary와 동일하게 설정 */
}
```

### 다크모드 규칙
- `bg-white` 대신 `bg-background` 사용
- `text-black` 대신 `text-foreground` 사용
- 하드코딩된 색상 절대 사용 금지 -- CSS variable 또는 Tailwind semantic class만 사용
- 이미지/아이콘의 다크모드 대응 확인

---

## 그림자 & 보더

### 그림자
| 토큰 | Tailwind | 값 | 용도 |
|-------|----------|-----|------|
| shadow-sm | `shadow-sm` | `0 1px 2px rgba(0,0,0,0.05)` | 미세한 깊이감 |
| shadow | `shadow` | `0 1px 3px rgba(0,0,0,0.1), 0 1px 2px rgba(0,0,0,0.06)` | 카드 기본 |
| shadow-md | `shadow-md` | `0 4px 6px rgba(0,0,0,0.1)` | 떠있는 요소 |
| shadow-lg | `shadow-lg` | `0 10px 15px rgba(0,0,0,0.1)` | 모달, 드롭다운 |
| shadow-xl | `shadow-xl` | `0 20px 25px rgba(0,0,0,0.1)` | 팝오버 |

### 보더
| 토큰 | Tailwind | 값 |
|-------|----------|-----|
| border | `border` | `1px solid hsl(var(--border))` |
| border-2 | `border-2` | `2px solid hsl(var(--border))` |
| rounded-sm | `rounded-sm` | `0.125rem` |
| rounded | `rounded` | `0.25rem` |
| rounded-md | `rounded-md` | `0.375rem` |
| rounded-lg | `rounded-lg` | `0.5rem` |
| rounded-xl | `rounded-xl` | `0.75rem` |
| rounded-2xl | `rounded-2xl` | `1rem` |
| rounded-full | `rounded-full` | `9999px` |

---

## 애니메이션 & 트랜지션

### 기본 트랜지션
| 용도 | Tailwind | 값 |
|------|----------|-----|
| 색상 변경 | `transition-colors` | `150ms ease` |
| 모든 속성 | `transition-all` | `150ms ease` |
| 크기 변경 | `transition-transform` | `150ms ease` |
| 투명도 | `transition-opacity` | `150ms ease` |
| 그림자 | `transition-shadow` | `150ms ease` |

### 지속 시간
| 토큰 | 값 | 용도 |
|-------|-----|------|
| fast | `duration-150` | 호버, 포커스 |
| normal | `duration-200` | 일반 전환 |
| slow | `duration-300` | 페이지 전환, 모달 |
| slower | `duration-500` | 복잡한 애니메이션 |

### 자주 쓰는 애니메이션
```css
/* 페이드 인 */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

/* 슬라이드 업 */
@keyframes slideUp {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 스케일 인 */
@keyframes scaleIn {
  from { opacity: 0; transform: scale(0.95); }
  to { opacity: 1; transform: scale(1); }
}
```

---

## shadcn/ui 커스터마이징 가이드

### 기본 테마 수정
1. `globals.css`에서 CSS 변수 수정 (위의 다크모드 토큰 매핑 참고)
2. `tailwind.config.ts`에서 확장 색상 추가
3. `components.json`에서 기본 설정 확인

### 컴포넌트 커스터마이징 우선순위
1. **CSS 변수 수정** -- 가장 선호. 전역 테마 변경
2. **className prop** -- 개별 인스턴스 스타일 오버라이드
3. **variants 추가** -- `cva`를 사용해 새 variant 정의
4. **컴포넌트 래핑** -- 기존 컴포넌트를 감싸서 확장
5. **컴포넌트 포크** -- 최후의 수단. 원본을 직접 수정

### 새 variant 추가 예시
```tsx
// components/ui/button.tsx의 buttonVariants에 추가
const buttonVariants = cva("...", {
  variants: {
    variant: {
      // 기존 variants...
      brand: "bg-brand text-brand-foreground hover:bg-brand/90",
    },
  },
});
```

### 테마 확장 시 주의사항
- shadcn/ui 업데이트 시 충돌 최소화를 위해 원본 파일 직접 수정은 최소화
- 커스텀 variant는 별도 파일로 관리하는 것을 권장
- `cn()` 유틸리티를 항상 사용하여 클래스 병합

---

## 접근성 규칙

### 필수 사항
- **색상 대비**: WCAG AA 기준 충족 (일반 텍스트 4.5:1, 큰 텍스트 3:1)
- **키보드 네비게이션**: 모든 인터랙티브 요소는 Tab으로 접근 가능해야 함
- **포커스 표시**: `focus-visible:ring-2 ring-ring ring-offset-2` 적용
- **스크린 리더**: 의미 있는 `aria-label`, `aria-describedby` 제공
- **이미지**: 모든 이미지에 `alt` 텍스트 필수
- **폼**: `<label>` 연결 필수, 에러 메시지는 `aria-live="polite"`
- **터치 타겟**: 최소 44x44px (모바일)

### 색상만으로 정보 전달 금지
- 에러: 빨간색 + 아이콘 + 텍스트
- 성공: 녹색 + 아이콘 + 텍스트
- 상태: 색상 + 레이블 텍스트

### 모션 접근성
```css
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```
