"use client";
import { cn } from '@/lib/utils'
import { usePathname } from 'next/navigation'
import React, { PropsWithChildren } from 'react'
import { FiBriefcase } from 'react-icons/fi';
import { HiOutlineUserGroup } from 'react-icons/hi';

export const PAGES = [
	{
		label: 'Employees',
    href: '/employee',
    icon: HiOutlineUserGroup
	},
  {
    label: 'Jobs',
    href: '/job',
    icon: FiBriefcase
  },
]

const PageWithHeader = ({children, className} : PropsWithChildren<{className: string}>) => {
	return (
		<div className={cn('flex flex-col h-screen', className)}>
			<PageHeader />
			<div className='flex-1 px-4'>
				{children}
			</div>
		</div>
	)
}

const PageHeader = () => {
	const currentPath = usePathname()
	const currentPage = PAGES.filter(page => page.href === currentPath)
	const Icon = currentPage[0].icon
	const label = currentPage[0].label
	return (
    <div className="flex p-4 bg-white mb-2 justify-start items-center gap-4 group">
      <Icon className="text-2xl text-gray-600" />
      <h1 className="text-2xl text-gray-800 font-semibold grow capitalize">
        {label}
      </h1>
    </div>
	)
}
export default PageWithHeader